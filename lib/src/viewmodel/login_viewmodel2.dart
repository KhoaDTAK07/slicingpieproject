import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/helper/validation2.dart';
import 'package:slicingpieproject/src/repos/login_repo.dart';

class LoginViewModel2 extends Model {
  LoginRepo _loginRepo = LoginRepoImp();

  String _tokenLogIn;
  String get tokenLogIn => _tokenLogIn;

  Validation2 _email = Validation2(null, null);
  Validation2 _password = Validation2(null, null);

  Validation2 get email => _email;
  Validation2 get password => _password;

  bool _isReady = true;
  bool _isLoading = false;

  bool get isReady => _isReady;
  bool get isLoading => _isLoading;

  void checkEmail(String email) async {
    notifyListeners();
    if(email != null){
      _email = Validation2(email, null);
    }
    if(email == null) {
      _email = Validation2(null,"Username can't be blank");
    }
    notifyListeners();
  }

  void checkPassword(String password) async {
    notifyListeners();
    if(password == null){
      _password = Validation2(null, "Password can't be blank");
    } else if(password.length < 6){
      _password = Validation2(null, "Password require minimum 6 characters");
    } else {
      _password = Validation2(password, null);
    }
    notifyListeners();
  }

  Future checkLogin() async {
    _isReady = true;

    if(_email.value == null) {
      print("----Email---");
      print(_email.value);
      checkEmail(null);
      _isReady = false;
    }
    if(_password.value == null) {
      print("----Pass---");
      print(_password.value);
      checkPassword(null);
      _isReady = false;
    }

    if(_isReady == true){
      _isLoading = true;
      notifyListeners();

      _tokenLogIn = await _loginRepo.checkNormalLogin(_email.value, _password.value);
      if(_tokenLogIn != null) {
        _tokenLogIn = tokenLogIn;
        _isLoading = false;
        notifyListeners();
      }
    }

  }

  Future<dynamic> checkGoogleLogin() async {
//    _isLoading = true;
//    notifyListeners();
//
//    Map<String,dynamic> map = await _loginRepo.checkGoogleLogin();
//
//    return map;
    return _loginRepo.checkGoogleLogin();
  }


}