import 'dart:async';
import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:slicingpieproject/src/helper/validation.dart';
import 'package:slicingpieproject/src/helper/api_string.dart';
import 'package:slicingpieproject/src/model/company_model.dart';
import 'package:slicingpieproject/src/model/stakeholder_model.dart';
import 'package:slicingpieproject/src/model/user_login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:slicingpieproject/src/model/sign_in_google_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/repos/stakeholder_repo.dart';
import 'package:slicingpieproject/src/repos/user_login_repo.dart';

class LoginViewModel extends Model{
  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  String stakeHolderID, companyID, role, tokenUser;
  int statusCode;
  StakeHolderList stakeHolderList;
  Company company;

  StakeHolderRepo stakeHolderRepo = StakeHolderRepoImp();
  UserLoginRepo userRepo = UserLoginRepoImp();

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

  Future<String> normalSignIn(String email, String pass) async {
    String apiCheckFirebase = APIString.apiCheckFirebaseNormalLogin();
    String json = jsonEncode(UserLogin(email, pass).toJson());

    String tokenLogIn = await userRepo.getUserToken(apiCheckFirebase, json);
    print("tokenLogIn: " + tokenLogIn);
    return tokenLogIn;
  }

  Future<String> googleSignIn() async {
    String json = await userRepo.getUserTokenByGoogleSignIn();
    return json;
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