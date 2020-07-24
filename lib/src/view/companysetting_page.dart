import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/view/project_list_page.dart';
import 'package:slicingpieproject/src/view/loading_page.dart';
import 'package:slicingpieproject/src/viewmodel/company_setting_viewmodel.dart';

import 'company_termlist_page.dart';

class CompanySettingPage extends StatelessWidget {
  final CompanySettingViewModel model;

  CompanySettingPage({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<CompanySettingViewModel>(
      model: model,
      child: Scaffold(
        appBar: new AppBar(
          title: new Text("Company Setting"),
          backgroundColor: Colors.blueAccent,
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                model.editCompanyDetail();
              },
              color: Colors.blueAccent,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
        body: ScopedModelDescendant<CompanySettingViewModel>(
            builder: (context, child, model) {
          if (model.isLoading) {
            return LoadingState();
          } else {
            return Container(
              constraints: BoxConstraints.expand(),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        model.getMyImage();
                      },
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 100,
                            backgroundColor: Color(0xff476cfb),
                            child: ClipOval(
                              child: SizedBox(
                                width: 180,
                                height: 180,
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                            child: Text(
                              "Click here to change Company Logo",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Company Name",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: 60,
                      child: TextFormField(
                        controller: model.name,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: model.company.name,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                        ),
                        onChanged: (value) {
                          model.changeName(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Non-Cash Multiplayer: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: 60,
                      child: TextFormField(
                        controller: model.nonMultiplayer,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '1 2 3',
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                        ),
                        onChanged: (value) {
                          model.changeNonCash(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Cash Multiplayer: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: 60,
                      child: TextFormField(
                        controller: model.multiplayer,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '1 2 3',
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                        ),
                        onChanged: (value) {
                          model.changeCash(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Cash Per Slice: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: 60,
                      child: TextFormField(
                        controller: model.cashPerSlice,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '100000',
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                        ),
                        onChanged: (value) {
                          model.changeCashPerSlice(value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProjectListPage()),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 9,
                              child: Text(
                                "Project List",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TermListPage()),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 9,
                              child: Text(
                                "Term",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}

