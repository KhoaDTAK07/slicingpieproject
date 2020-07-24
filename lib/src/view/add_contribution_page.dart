import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/viewmodel/add_contribution_viewmodel.dart';

class AddContributionPage extends StatelessWidget {
  final AddContributionViewmodel model;
  final String dateFrom, dateTo;

  AddContributionPage({this.model, this.dateFrom, this.dateTo});

  final quantity = TextEditingController();
  final description = TextEditingController();

  Future selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.parse(dateFrom),
        lastDate: DateTime.parse(dateTo));
    if (pickedDate != null) {
      model.selectedDate = pickedDate;
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AddContributionViewmodel>(
      model: model,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text("Add Contribution"),
        ),
        body: ScopedModelDescendant<AddContributionViewmodel>(
          builder: (context, child, addModel) {
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
                            _accountField(),
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
                            _projectListField(),
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
                            _typeAssetListField(),
                            SizedBox(
                              width: double.infinity,
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    30, 30, 30, 0),
                                child: RaisedButton(
                                  onPressed: () async {
                                    bool isCreate = await model.addContribution();
                                    print(isCreate);
                                    if(isCreate) {
                                      Fluttertoast.showToast(
                                        msg: "Add Contribution success",
                                        textColor: Colors.red,
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: Colors.white,
                                        gravity: ToastGravity.CENTER,
                                      );
                                      Navigator.of(context).pop();
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Add Contribution fail",
                                        textColor: Colors.red,
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: Colors.white,
                                        gravity: ToastGravity.CENTER,
                                      );
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text(
                                    "Add new Contribution",
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
                    ));
          },
        ),
      ),
    );
  }

  Widget _dateField(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectDate(context);
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
                model.selectedDateFormat,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _accountField() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
      child: TextField(
        controller: model.accountFieldController,
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
        controller: quantity,
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
        controller: description,
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

  Widget _projectListField() {
    return Container(
        height: 50,
        width: 375,
        padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
        decoration: new BoxDecoration(
          border: Border.all(
            color: Colors.teal,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: <Widget>[
            DropdownButton<String>(
              items: model.projectName.map((String dropdownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropdownStringItem,
                  child: Text(dropdownStringItem),
                );
              }).toList(),
              onChanged: (selectedValue) {
                model.changeSelectedProject(selectedValue);
              },
              value: model.selectedProject,
              hint: Text(
                'Choose project',
                style: TextStyle(fontSize: 18),
              ),
              iconSize: 28,
              elevation: 16,
            ),
          ],
        ));
  }

  Widget _typeAssetListField() {
    return Container(
        height: 50,
        width: 375,
        padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
        decoration: new BoxDecoration(
          border: Border.all(
            color: Colors.teal,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: <Widget>[
            DropdownButton<String>(
              items: model.typeContribute
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (selectedValue) {
                model.changeSelectedTypeAsset(selectedValue);
              },
              value: model.selectedTypeContribute,
              hint: Text(
                'Choose Type of Assets',
                style: TextStyle(fontSize: 18),
              ),
              iconSize: 28,
              elevation: 16,
            ),
          ],
        ));
  }
}
