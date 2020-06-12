import 'dart:async';
import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:slicingpieproject/src/helper/validation.dart';
import 'package:slicingpieproject/src/helper/api_string.dart';
import 'package:slicingpieproject/src/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginViewModel {
  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

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

  normalSignIn(String email, String pass) async {
    String apiCheckFirebase = APIString.apiCheckFirebaseNormalLogin();
    String apiLogin = APIString.apiLogin();

    String json =  jsonEncode(User(email, pass).toJson());
    print(json);

    http.Response responseAPICheckFirebase = await http.post(apiCheckFirebase, body: json);
    int statusCodePost = responseAPICheckFirebase.statusCode;

    Map<String, dynamic> map1 = jsonDecode(responseAPICheckFirebase.body);
    String tokenLogIn = map1['idToken'];

    Map<String, String> headersPost = {
      HttpHeaders.authorizationHeader: tokenLogIn,
    };

    http.Response responseAPILogin = await http.post(apiLogin, headers: headersPost);
    Map<String, dynamic> map2 = jsonDecode(responseAPILogin.body);


    print(responseAPICheckFirebase.body);
    print("------------");
    print(responseAPILogin.body);

//    Future<dynamic> list = jsonDecode(response.body);
//    return list;
  }

  dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _btnSubject.close();
  }

}