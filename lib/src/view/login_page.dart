import 'dart:io';
import 'package:flutter/material.dart';
import 'package:slicingpieproject/src/resources/home_page.dart';
import 'package:slicingpieproject/src/resources/sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:slicingpieproject/src/model/stakeholder_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slicingpieproject/src/viewmodel/login_viewmodel.dart';
import 'package:slicingpieproject/src/helper/api_string.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int statusCode;
  String jsonList;
  StakeHolderList stakeHolderList;

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
    });

    // Catch user's password input data
    passwordController.addListener(() {
      // Call passSink to add data to Stream
      loginViewModel.passwordSink.add(passwordController.text);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    loginViewModel.dispose();
  }


  _makeLoginPostRequest() async {
    String firebaseToken = await signInWithGoogle();
    // set up POST request arguments
    String urlAPI = APIString.apiLogin();
    String urlAPIGetList = APIString.apiGetListStakeHolder();

    Map<String, String> headersPost = {
      HttpHeaders.authorizationHeader: firebaseToken,
    };
    http.Response responsePost = await http.post(urlAPI, headers: headersPost);

    int statusCodePost = responsePost.statusCode;
    Map<String, dynamic> map = jsonDecode(responsePost.body);
    String content = map['token'];

    String tokenLogin = content;

    print(statusCodePost);
    print('Token Login: ' + tokenLogin);

    Map<String, String> headersGet = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $tokenLogin",
    };
    http.Response responseGet = await http.get(urlAPIGetList, headers: headersGet);

    int statusCodeGet = responseGet.statusCode;

    jsonList = responseGet.body;
    List<dynamic> list = jsonDecode(responseGet.body);
    if (!list.isEmpty){
      statusCode = 200;
    }

    stakeHolderList = StakeHolderList.fromJson(list);

    print(statusCodeGet);
    print('List: ' + jsonList);
    print("Test: " + stakeHolderList.stakeholderList[2].shName);
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
                        onPressed: snapshot.data == true ? () {} : null,
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
                      _makeLoginPostRequest().whenComplete(() {
                        if(statusCode == 200){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomePage(list: stakeHolderList),
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