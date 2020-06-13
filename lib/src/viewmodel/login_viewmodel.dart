import 'dart:async';
import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:slicingpieproject/src/helper/validation.dart';
import 'package:slicingpieproject/src/helper/api_string.dart';
import 'package:slicingpieproject/src/model/company_model.dart';
import 'package:slicingpieproject/src/model/stakeholder_model.dart';
import 'package:slicingpieproject/src/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:slicingpieproject/src/model/sign_in_google_model.dart';

class LoginViewModel {
  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  String stakeHolderID, companyID, role, tokenUser;
  int statusCode;
  StakeHolderList stakeHolderList;
  Company company;

  var emailValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      sink.add(Validation.validateEmail(email));
    }
  );

  var passwordValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (pass, sink){
        sink.add(Validation.validatePass(pass));
      }
  );

  Stream<String> get emailStream => _emailSubject.stream.transform(emailValidation);
  Sink<String> get emailSink => _emailSubject.sink;

  Stream<String> get passwordStream => _passwordSubject.stream.transform(passwordValidation);
  Sink<String> get passwordSink => _passwordSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  LoginViewModel() {
    Observable.combineLatest2(_emailSubject, _passwordSubject, (email, pass) {
      return Validation.validateEmail(email) == null && Validation.validatePass(pass) == null;
    }).listen((enable) {
          btnSink.add(enable);
    });
  }

  Future<StakeHolderList> normalSignIn(String email, String pass) async {

    String apiCheckFirebase = APIString.apiCheckFirebaseNormalLogin();
    String apiLogin = APIString.apiLogin();

    String json =  jsonEncode(User(email, pass).toJson());
    print(json);

    //Post API to check authen Firebase
    http.Response responseAPICheckFirebase = await http.post(apiCheckFirebase, body: json);
    int statusCodePost = responseAPICheckFirebase.statusCode;

    Map<String, dynamic> map1 = jsonDecode(responseAPICheckFirebase.body);
    String tokenLogIn = map1['idToken'];

    //Post API Login to take token user
    Map<String, String> headersPost = {
      HttpHeaders.authorizationHeader: tokenLogIn,
    };

    http.Response responseAPILogin = await http.post(apiLogin, headers: headersPost);
    Map<String, dynamic> map2 = jsonDecode(responseAPILogin.body);
    tokenUser = map2['token'];
    companyID = map2['companyId'];

    print(responseAPICheckFirebase.body);
    print("------------");
    print(companyID);

    //  Use token user to take list of StakeHolder
    String apiGetList = APIString.apiGetListStakeHolder(companyID);
    Map<String, String> headersGet = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };
    http.Response responseGet = await http.get(apiGetList, headers: headersGet);
    print(responseGet.body);

    List<dynamic> list = jsonDecode(responseGet.body);

    stakeHolderList = StakeHolderList.fromJson(list);
    print("Test: " + stakeHolderList.stakeholderList[2].shName);
    return stakeHolderList;
  }

  Future<StakeHolderList> googleSignIn() async {
    //Sign in with Google to get Firebase Token
    String firebaseToken = await signInWithGoogle();
    //Post API login to take a user's token
    String apiLogin = APIString.apiLogin();

    Map<String, String> headersPost = {
      HttpHeaders.authorizationHeader: firebaseToken,
    };
    http.Response responseAPILogin = await http.post(apiLogin, headers: headersPost);

    int statusCodePost = responseAPILogin.statusCode;
    Map<String, dynamic> map = jsonDecode(responseAPILogin.body);
    tokenUser = map['token'];
    companyID = map['companyId'];

    print(statusCodePost);
    print('Token Login: ' + tokenUser);

    //Use token user to take list of StakeHolder
    String apiGetList = APIString.apiGetListStakeHolder(companyID);
    Map<String, String> headersGet = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };
    http.Response responseGet = await http.get(apiGetList, headers: headersGet);
    print(responseGet.body);

    List<dynamic> list = jsonDecode(responseGet.body);

    stakeHolderList = StakeHolderList.fromJson(list);
    print("Test: " + stakeHolderList.stakeholderList[2].shName);
    return stakeHolderList;
  }

  String token() {
    String userToken = tokenUser;
    return userToken;
  }

  Future<Map<String, dynamic>> getCompanyProfile(String companyID, String tokenUser) async {
    // API get Company Profile
    String apiGetCompanyProfile = APIString.apiCompanySetting(companyID);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };
    http.Response response = await http.get(apiGetCompanyProfile, headers: headers);

    Map<String, dynamic> json = jsonDecode(response.body);
    return json;
  }

  dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _btnSubject.close();
  }

}