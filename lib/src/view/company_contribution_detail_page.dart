import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/view/loading_page.dart';
import 'package:slicingpieproject/src/viewmodel/company-history-contribute-vm.dart';
import 'package:slicingpieproject/src/viewmodel/company_contribution_detail_viewmodel.dart';

import 'company-history-contribute-page.dart';

class CompanyContributionDetailPage extends StatelessWidget {
  final CompanyContributionDetailViewModel model;

  CompanyContributionDetailPage({this.model});


  @override
  Widget build(BuildContext context) {
    return ScopedModel<CompanyContributionDetailViewModel>(
      model: model,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text("Contribution Detail"),
        ),
        body: ScopedModelDescendant<CompanyContributionDetailViewModel>(
          builder: (context, child, model) {
            if(model.isLoading) {
              return LoadingState();
            } else {
              return Builder(
                builder: (contextBuilder) => Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
                          child: Text(
                            "Date: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _dateField(context),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                          child: Text(
                            "StakeHolder Name: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _stakeHolderNameField(),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                          child: Text(
                            "Quantity: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _quantityField(),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                          child: Text(
                            "Description: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _descriptionField(),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                          child: Text(
                            "Project *: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _projectField(),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                          child: Text(
                            "Type Assets *: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _typeAssetField(),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                          child: Text(
                            "Term: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _termField(),

                        SizedBox(
                          width: double.infinity,
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                30, 30, 30, 0),
                            child: RaisedButton(
                              onPressed: () async {
                                bool isUpdated = await model.updateContribution();
                                print("---------");
                                print(isUpdated);
                                if(isUpdated) {
                                  Fluttertoast.showToast(
                                    msg: "Update Contribution success",
                                    textColor: Colors.red,
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: Colors.white,
                                    gravity: ToastGravity.CENTER,
                                  );
                                  Navigator.of(context).pop();
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Update Contribution fail",
                                    textColor: Colors.red,
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: Colors.white,
                                    gravity: ToastGravity.CENTER,
                                  );
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                "Update Contribution",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(6)),
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
        )
      ),
    );
  }

  Widget _dateField(BuildContext context) {
    return GestureDetector(
      onTap: () {
//        selectDate(context);
      },
      child: ListTile(
        title: new InputDecorator(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.calendar_today),
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.teal)),
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
                model.date,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stakeHolderNameField() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
      child: TextField(
        controller: model.stakeHolderNameController,
        readOnly: true,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ),
      ),
    );
  }

  Widget _quantityField() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
      child: TextField(
        controller: model.quantityController,
        onChanged: (text) {
          model.checkQuantity(text);
        },
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          errorText: model.quantity.error,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _descriptionField() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
      child: TextField(
        controller: model.descriptionController,
        onChanged: (text) {
          model.checkDescription(text);
        },
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          errorText: model.description.error,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ),
      ),
    );
  }

  Widget _typeAssetField() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
      child: TextField(
        controller: model.typeAssetController,
//        onChanged: (text) {
//          model.checkDescription(text);
//        },
        readOnly: true,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
//          errorText: model.description.error,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ),
      ),
    );
  }

  Widget _projectField() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
      child: TextField(
        controller: model.projectIDController,
//        onChanged: (text) {
//          model.checkDescription(text);
//        },
        readOnly: true,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
//          errorText: model.description.error,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ),
      ),
    );
  }

  Widget _termField() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
      child: TextField(
        controller: model.termIDController,
//        onChanged: (text) {
//          model.checkDescription(text);
//        },
        readOnly: true,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
//          errorText: model.description.error,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ),
      ),
    );
  }

}