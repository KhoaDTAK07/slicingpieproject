import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/model/sign_in_google_model.dart';
import 'package:slicingpieproject/src/view/home_page.dart';
import 'package:slicingpieproject/src/viewmodel/home_page_viewmodel.dart';
import 'package:slicingpieproject/src/viewmodel/login_viewmodel2.dart';

class LoginPage2 extends StatelessWidget {
  final LoginViewModel2 model;

  LoginPage2(this.model);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LoginViewModel2>(
      model: model,
      child: Scaffold(
        body: ScopedModelDescendant<LoginViewModel2>(
          builder: (context, child, model) {
            return Builder(
                builder: (contextBuilder) => Container(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      constraints: BoxConstraints.expand(),
                      color: Color.fromARGB(250, 193, 212, 241),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                            ),
                            Image.asset('banner.png'),
                            SizedBox(
                              height: 10,
                            ),
                            _emailField(),
//                            SizedBox(
//                              height: 10,
//                            ),
                            _passwordField(),

                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: RaisedButton(
                                onPressed: () async {
                                  if(model.email.value == null || model.password.value == null) {
                                    Fluttertoast.showToast(
                                        msg: "Email and Password can't be blank",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  } else {
                                    Map<String, dynamic> map = await model.checkLogin();
                                    if(map.length == 1) {
                                      Fluttertoast.showToast(
                                          msg: "Your Account is inactive",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    } else {
                                      Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => HomePage(model: HomePageViewModel(map),),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                color: Color(0xff3277DB),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: RaisedButton(
                                onPressed: () async {
                                  Map<String, dynamic> map = await model.checkGoogleLogin();
                                  if(map.length == 1) {
                                    signOutGoogle();
                                    Fluttertoast.showToast(
                                        msg: "Your Account is inactive",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  } else {
                                    String tokenLogIn = "anc";
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => HomePage(model: HomePageViewModel(map),),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "Sign In with Gmail",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                color: Color(0xff3277DB),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
          },
        ),
      ),
    );
  }

  Widget _emailField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: TextField(
        controller: emailController,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        onChanged: (text) {
          model.checkEmail(text);
        },
        decoration: InputDecoration(
          labelText: "Username *",
          hintText: "example@gmail.com",
          errorText: model.email.error,
          prefixIcon: Container(
            width: 5,
            child: Image.asset('ic_username.png'),
          ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: TextField(
        controller: passwordController,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        onChanged: (text) {
          model.checkPassword(text);
        },
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password *",
          errorText: model.email.error,
          prefixIcon: Container(
            width: 5,
            child: Image.asset('ic_password.png'),
          ),
        ),
      ),
    );
  }
}
