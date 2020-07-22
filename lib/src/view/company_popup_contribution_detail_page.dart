import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/view/company_contribution_detail_page.dart';
import 'package:slicingpieproject/src/view/companysetting_page.dart';
import 'package:slicingpieproject/src/viewmodel/company_contribution_detail_viewmodel.dart';

class CompanyContributionPopUpDetailPage extends StatelessWidget {
  final CompanyContributionDetailViewModel model;

  CompanyContributionPopUpDetailPage({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CompanyContributionDetailViewModel>(
      model: model,
      child: Scaffold(
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
                        Row(
                          children: <Widget>[
                            Container(
                              child: Icon(Icons.schedule),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Text(
                                  'Date',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Text(
                                  DateFormat('yyyy-MM-dd')
                                      .format(DateTime.parse(model.date)),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Icon(Icons.monetization_on),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Text(
                                  'Quantity ',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Text(model.quantityController.text),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Icon(Icons.description),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Text(
                                  'Description',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Text(model.descriptionController.text),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Icon(Icons.image),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Text(
                                  'Type Asset',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Text(model.typeAssetController.text),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Icon(Icons.image),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Text(
                                  'Term',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Text(model.termIDController.text),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                            child: RaisedButton(
                              onPressed: () async {
                                print(model.assetIDController);
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CompanyContributionDetailPage(
                                          model: CompanyContributionDetailViewModel(
                                              model.assetIDController.text,
                                              model.stakeHolderNameController.text),
                                        ),
                                  ),
                                ).then((value) => model.getContributionDetail(model.assetIDController.text));
                              },
                              child: Text(
                                "Edit Contribution",
                                style:
                                TextStyle(color: Colors.white, fontSize: 18),
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
//              new Text(
//                model.date,
//              ),
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

}