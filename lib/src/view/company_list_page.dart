import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/view/companysetting_page.dart';
import 'package:slicingpieproject/src/view/loading_page.dart';
import 'package:slicingpieproject/src/viewmodel/company_switch_viewmodel.dart';
import 'package:slicingpieproject/src/viewmodel/home_page_viewmodel.dart';

import 'home_page.dart';
import 'not_found_page.dart';

class ListCompanyPage extends StatelessWidget {
  final CompanySwitchViewModel model;

  ListCompanyPage({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CompanySwitchViewModel>(
      model: model,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text(
            "List Of Company",
            textAlign: TextAlign.center,
          ),
        ),
        body: GestureDetector(
          child: Column(
            children: <Widget>[
              ScopedModelDescendant<CompanySwitchViewModel>(
                  builder: (context, child, model) {
                    if (model.isLoading) {
                      return LoadingState();
                    } else if (model.companyList.companyList.isEmpty){
                      return NotFoundPage();
                    } else {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: _drawSlidable(context, model),
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawSlidable(BuildContext context, CompanySwitchViewModel model) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: model.companyList.companyList.length,
      itemBuilder: (context, index) {
        return Slidable(
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.5,
          child: _getListCompany(context, index, model),
        );
      },
    );
  }

  Widget _getListCompany(
      BuildContext context, int index, CompanySwitchViewModel model) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            print(model.companyList.companyList[index].id);
            Map<String, dynamic> map = await model.switchCompany(model.companyList.companyList[index].id);
            if(map.length == 1) {
              Fluttertoast.showToast(
                  msg: "Switch Company fail!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            } else {
              Fluttertoast.showToast(
                  msg: "Switch Company success!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  HomePage(model: HomePageViewModel(map))), (Route<dynamic> route) => false);
            }
          },
          child: Row(
            children: <Widget>[
              Container(
                child: CircleAvatar(
                  radius: 43.0,
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage:
                    NetworkImage(model.companyList.companyList[index].icon),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: Column(
                  children: <Widget>[
                    Text(
                      model.companyList.companyList[index].name,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.black12,
                width: double.infinity,
                height: 2,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
