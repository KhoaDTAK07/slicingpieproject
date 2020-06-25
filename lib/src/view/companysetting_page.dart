import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/viewmodel/company_setting_viewmodel.dart';

class CompanySettingPage extends StatelessWidget {
  final CompanySettingViewModel model;
  String edtCompany, edtNonCash, edtCash, icon;

  CompanySettingPage({Key key, this.model}) : super(key: key);

  Future<dynamic> saveEdtCompany() async {
    model.editCompanyDetail(edtCompany, icon, edtNonCash, edtCash);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: ScopedModel<CompanySettingViewModel>(
        model: model,
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.blueAccent,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {}
                );
              },
            ),
            title: new Text("Company Setting"),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  saveEdtCompany();
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
                          Image.asset(
                            'logo.png',
                            height: 200,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                            child: Text(
                              "Click here to change Company Logo",
                              style: TextStyle(color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
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
                                  style: TextStyle(color: Colors.black,
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
                              initialValue: model.company.name,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: model.company.name,
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.teal)
                                ),
                              ),
                              onChanged: (edt) {
                                edtCompany = edt;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Non-Cash Multiplayer: ",
                                  style: TextStyle(color: Colors.black,
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
                              initialValue: model.company.nonMultiplayer
                                  .toString(),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '1 2 3',
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.teal)
                                ),
                              ),
                              onChanged: (edt) {
                                edtNonCash = edt.toString();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Cash Multiplayer: ",
                                  style: TextStyle(color: Colors.black,
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
                              initialValue: model.company.multiplayer
                                  .toString(),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '1 2 3',
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.teal)
                                ),
                              ),
                              onChanged: (edt) {
                                edtCash = edt.toString();
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
                              onPressed: () {},
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
                          )
                        ],
                      ),
                    ),
                  );
                }
              }
          ),
        ),
      ),
    );
  }
}



class LoadingState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

}