import 'package:slicingpieproject/src/view/companysetting_page.dart';
import 'package:slicingpieproject/src/view/login_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CompanySettingPage()
    ); //Material App
  }
}