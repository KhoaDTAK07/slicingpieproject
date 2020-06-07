import 'dart:io';
import 'package:flutter/material.dart';
import 'package:slicingpieproject/src/resources/home_page.dart';
import 'package:slicingpieproject/src/resources/sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:slicingpieproject/src/stakeholder/stakeholder_model.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int statusCode;
  String jsonList;
  StakeHolderList stakeHolderList;

  _makeLoginPostRequest() async {
    String firebaseToken = await signInWithGoogle();
    // set up POST request arguments
    String urlAPI = 'https://slicingpieproject.azurewebsites.net/api/login';
    String urlAPIGetList = 'https://slicingpieproject.azurewebsites.net/api/StackHolders';

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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                child: TextField(
                  style: TextStyle(fontSize: 18, color: Colors.black,),
                  decoration: InputDecoration(
                    labelText: "Username",
                    prefixIcon: Container(
                      width: 5, child: Image.asset('ic_username.png'),
                    ),
                  ),
                ),
              ),
              TextField(
                style: TextStyle(fontSize: 18, color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Container(
                    width: 53, height: 30, child: Image.asset("ic_password.png"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: () {},
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