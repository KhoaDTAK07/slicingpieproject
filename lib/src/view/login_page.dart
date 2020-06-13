import 'dart:io';
import 'package:flutter/material.dart';
import 'package:slicingpieproject/src/resources/home_page.dart';
import 'package:slicingpieproject/src/model/sign_in_google_model.dart';
import 'package:slicingpieproject/src/model/stakeholder_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slicingpieproject/src/viewmodel/login_viewmodel.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int statusCode;
  String jsonList;
  StakeHolderList stakeHolderList;
  String json,email,pass;
  String userToken;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginViewModel = LoginViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Catch user's email input data
    emailController.addListener(() {
      // Call emailSink to add data to Stream
      loginViewModel.emailSink.add(emailController.text);
      email = emailController.text;
    });

    // Catch user's password input data
    passwordController.addListener(() {
      // Call passSink to add data to Stream
      loginViewModel.passwordSink.add(passwordController.text);
      pass = passwordController.text;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    loginViewModel.dispose();
  }


  Future<dynamic> getListStakeHolderWithNormalSignIn() async {
    stakeHolderList = await loginViewModel.normalSignIn(email.trim(), pass.trim());
    userToken = loginViewModel.token();
    if(stakeHolderList != null){
      statusCode = 200;
    }
  }

  Future<dynamic> getListStakeHolderWithGoogleSignIn() async {
    stakeHolderList = await loginViewModel.googleSignIn();
    userToken = loginViewModel.token();
    if(stakeHolderList != null){
      statusCode = 200;
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Color.fromARGB(250, 193, 212, 241),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Image.asset('banner.png'),
              StreamBuilder<String>(
                stream: loginViewModel.emailStream,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                    child: TextFormField(
                      controller: emailController,
                      style: TextStyle(fontSize: 18, color: Colors.black,),
                      decoration: InputDecoration(
                        labelText: "Username *",
                        hintText: "example@gmail.com",
                        errorText: snapshot.data,
                        prefixIcon: Container(
                          width: 5, child: Image.asset('ic_username.png'),
                        ),
                      ),
                    ),
                  );
                }
              ),
              StreamBuilder<String>(
                stream: loginViewModel.passwordStream,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    child: TextFormField(
                      controller: passwordController,
                      style: TextStyle(fontSize: 18, color: Colors.black,),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password *",
                        errorText: snapshot.data,
                        prefixIcon: Container(
                          width: 5, child: Image.asset('ic_password.png'),
                        ),
                      ),
                    ),
                  );
                }
              ),
              StreamBuilder<bool>(
                stream: loginViewModel.btnStream,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: RaisedButton(
                        onPressed: snapshot.data == true ? () {
                          getListStakeHolderWithNormalSignIn().whenComplete(() {
                            print(statusCode);
                            if(statusCode == 200){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HomePage(list: stakeHolderList, token: userToken),
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Your Account is inactive",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => LoginPage(),
                                  ));
                            }
                          });
                        } : null,
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        color: Color(0xff3277DB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                    ),
                  );
                }
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: () {
                      getListStakeHolderWithGoogleSignIn().whenComplete(() {
                        if(statusCode == 200){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomePage(list: stakeHolderList, token: userToken),
                            ),
                          );
                        }  else {
                          signOutGoogle();
                          Fluttertoast.showToast(
                              msg: "Your Account is inactive",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginPage(),
                              ));
                        }
                      });
                    },
                    child: Text(
                      "Sign-in with Gmail",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}