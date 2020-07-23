import 'package:slicingpieproject/src/view/add_account_founder_page.dart';
import 'package:slicingpieproject/src/view/add_contribution_page.dart';
import 'package:slicingpieproject/src/view/add_founder_page.dart';
import 'package:slicingpieproject/src/view/add_term_page.dart';
import 'package:slicingpieproject/src/view/companysetting_page.dart';
import 'package:flutter/material.dart';
import 'package:slicingpieproject/src/view/login_page2.dart';
import 'package:slicingpieproject/src/view/member_profile_page.dart';
import 'package:slicingpieproject/src/view/project_list_setting_page.dart';
import 'package:slicingpieproject/src/view/switch_company_page.dart';
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