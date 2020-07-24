import 'package:flutter/material.dart';
import 'package:slicingpieproject/src/view/login_page2.dart';
import 'package:slicingpieproject/src/viewmodel/login_viewmodel2.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage2(LoginViewModel2()),
    ); //Material App
  }
}