import 'dart:convert';
import 'dart:io';

import 'package:slicingpieproject/src/helper/api_string.dart';
import 'package:slicingpieproject/src/model/sign_in_google_model.dart';
import 'package:slicingpieproject/src/model/user_login_model.dart';
import 'package:http/http.dart' as http;

abstract class LoginRepo {
  Future<dynamic> checkNormalLogin(String email, String password);
  Future<dynamic> checkGoogleLogin();
}

class LoginRepoImp implements LoginRepo {

  @override
  Future<dynamic> checkNormalLogin(String email, String password) async{
    String apiCheckFirebase = APIString.apiCheckFirebaseNormalLogin();
    String jsonLogin = jsonEncode(UserLogin(email.trim(),password.trim()).toJson());

    http.Response responseCheckFirebase = await http.post(apiCheckFirebase, body: jsonLogin);

    Map<String, dynamic> map = jsonDecode(responseCheckFirebase.body);
    print("---abc: " + responseCheckFirebase.body);

    String tokenLogIn = map['idToken'];

    Map<String, String> header = {
      HttpHeaders.authorizationHeader: tokenLogIn,
    };

    String apiLogin = APIString.apiLogin();
    http.Response responseAPILogin = await http.post(apiLogin, headers: header);
    print("2: " + responseAPILogin.body);

    int statusCode = responseAPILogin.statusCode;
    print("Status Code: " + statusCode.toString());

    if(statusCode != 401) {
      Map<String, dynamic> json = jsonDecode(responseAPILogin.body);
      return json;

    } else {
      Map<String, dynamic> map = new Map<String,dynamic>();
      map['StatusCode'] = 401;
      return map;
    }

  }

  @override
  Future<dynamic> checkGoogleLogin() async{
    //Sign in with Google to get Firebase Token
    String firebaseToken = await signInWithGoogle();

    //Post API login to take a user's token
    String apiLogin = APIString.apiLogin();

    Map<String, String> headersPost = {
      HttpHeaders.authorizationHeader: firebaseToken,
    };
    http.Response response = await http.post(apiLogin, headers: headersPost);

    print("Response: " + response.body);

    int statusCode = response.statusCode;
    if(statusCode == 401) {
      Map<String, dynamic> map = new Map<String,dynamic>();
      map['StatusCode'] = 401;
      return map;
    } else {
      Map<String, dynamic> map = jsonDecode(response.body);
      return map;
    }

  }

}