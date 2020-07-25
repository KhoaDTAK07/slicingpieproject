import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/viewmodel/stakeHolder_detail_viewmodel.dart';

import 'loading_page.dart';

class ProfilePage extends StatelessWidget {
  final StakeHolderDetailViewModel model;

  ProfilePage({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<StakeHolderDetailViewModel>(
      model: model,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text(
            "Profile",
            textAlign: TextAlign.center,
          ),
        ),
        body: ScopedModelDescendant<StakeHolderDetailViewModel>(
          builder: (context, child, model) {
            if (model.isLoading) {
              return LoadingState();
            } else {
              return Builder(
                builder: (contextBuilder) => Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        _imageField(),
                        SizedBox(
                          height: 30,
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
                        _accountIDField(),
                        _shMarketSalaryField(),
                        _shSalaryField(),
                        _shJobField(),
                        _shNameForCompanyField(),
                        SizedBox(
                          width: double.infinity,
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                            child: RaisedButton(
                              onPressed: () async {
                                bool isUpdate = await model.updateStakeHolder();
                                if (isUpdate) {
                                  Fluttertoast.showToast(
                                    msg: "Update Profile success",
                                    textColor: Colors.red,
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.white,
                                    gravity: ToastGravity.CENTER,
                                  );
                                  Navigator.of(context).pop();
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Update Profile fail",
                                    textColor: Colors.red,
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.white,
                                    gravity: ToastGravity.CENTER,
                                  );
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                "Update Profile",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _imageField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(50, 20, 0, 0),
          child: CircleAvatar(
            radius: 110,
            backgroundColor: Colors.greenAccent,
            child: ClipOval(
              child: SizedBox(
                width: 200,
                height: 200,
                child: (model.image != null)
                    ? Image.file(
                  model.image,
                  fit: BoxFit.fill,
                )
                    : Image.network(
                  model.defaultImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 170, 0, 0),
            child: IconButton(
              icon: Icon(
                Icons.camera_alt,
                size: 30,
              ),
              onPressed: () {
                model.getMyImage();
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _accountIDField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
          child: Text(
            "AccountID: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: model.accountIDField,
            onChanged: (text) {
              model.checkAccountID(text);
            },
            readOnly: true,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              errorText: model.accountID.error,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _shMarketSalaryField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
          child: Text(
            "StakeHolder Market Salary: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: model.shMarketSalaryField,
            onChanged: (text) {
              model.checkShMarketSalary(text);
            },
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              errorText: model.shMarketSalary.error,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _shSalaryField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
          child: Text(
            "StakeHolder Salary: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: model.shSalaryField,
            onChanged: (text) {
              model.checkShSalary(text);
            },
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              errorText: model.shSalary.error,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _shJobField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
          child: Text(
            "StakeHolder Job: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: model.shJobField,
            onChanged: (text) {
              model.checkShJob(text);
            },
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              errorText: model.shJob.error,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _shNameForCompanyField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
          child: Text(
            "StakeHolder Name for Company: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: model.shNameForCompanyField,
            onChanged: (text) {
              model.checkShNameForCompany(text);
            },
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              errorText: model.shNameForCompany.error,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
            ),
          ),
        ),
      ],
    );
  }
}