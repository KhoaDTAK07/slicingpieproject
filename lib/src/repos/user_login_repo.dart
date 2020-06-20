import 'dart:io';

import 'package:slicingpieproject/src/helper/api_string.dart';
import 'package:slicingpieproject/src/model/sign_in_google_model.dart';
import 'package:slicingpieproject/src/model/user_login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class UserLoginRepo {
  Future<String> getUserToken(String api, String json);
  Future<dynamic> getUserTokenByGoogleSignIn();
}

class UserLoginRepoImp implements UserLoginRepo {

  @override
  Future<String> getUserToken(String api, String json) async {

    http.Response response = await http.post(api, body: json);

    Map<String, dynamic> map = jsonDecode(response.body);
    String userToken = map['idToken'];
//    print("userToken: " + userToken);
    return userToken;
  }

  @override
  Future<dynamic> getUserTokenByGoogleSignIn() async {
    // TODO: implement getUserTokenByGoogleSignIn
    //Sign in with Google to get Firebase Token
    String firebaseToken = await signInWithGoogle();

    //Post API login to take a user's token
    String apiLogin = APIString.apiLogin();

    Map<String, String> headersPost = {
      HttpHeaders.authorizationHeader: firebaseToken,
    };
    http.Response response = await http.post(apiLogin, headers: headersPost);
    print("login with gg: " + response.body);
    return response.body;
  }

}