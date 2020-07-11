import 'dart:convert';
import 'dart:io';

import 'package:slicingpieproject/src/helper/api_string.dart';
import 'package:slicingpieproject/src/model/user_login_detail_model.dart';
import 'package:http/http.dart' as http;

abstract class UserDetailRepo {
  Future<UserDetail> fetchUserLoginDetail (String tokenLogIn);
}

class UserDetailRepoImp implements UserDetailRepo {

  @override
  Future<UserDetail> fetchUserLoginDetail(String tokenLogIn) async {
    // TODO: implement fetchUserLoginDetail
    //Post API Login to take token user
    Map<String, String> headersPost = {
      HttpHeaders.authorizationHeader: tokenLogIn,
    };

    String apiLogin = APIString.apiLogin();
    http.Response responseAPILogin = await http.post(apiLogin, headers: headersPost);

    Map<String, dynamic> userDetail = jsonDecode(responseAPILogin.body);

    UserDetail userLogInDetail;
    userLogInDetail = UserDetail.fromJson(userDetail);
    return userLogInDetail;
  }

}