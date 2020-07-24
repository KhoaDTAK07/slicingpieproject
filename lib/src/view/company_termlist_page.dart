import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/view/project_list_in_term_page.dart';
import 'package:slicingpieproject/src/view/project_list_page.dart';
import 'package:slicingpieproject/src/viewmodel/company_termlist_viewmodel.dart';

class TermListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CompanyTermListViewModel>(
      model: new CompanyTermListViewModel(),
      child: ScopedModelDescendant<CompanyTermListViewModel>(
          builder: (context, child, model) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('List of Term'),
              ),
              body: FutureBuilder(
                  future: model.loadTermList(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {
                      if(!snapshot.hasData) {
                        return Center(
                          child: Text("No project"),
                        );
                      } else
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: ListView.builder(
                                    itemCount: model.termList.termList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return new GestureDetector(
                                        child: new ListTile(
                                            title: new Card(
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                            model.termList.termList[index].termName,
                                                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                            DateFormat('yyyy/MM/dd').format(DateTime.parse(model.termList.termList[index].termTimeFrom)),
                                                            style: TextStyle(fontSize: 18),
                                                          ),
                                                          Text(" - "),
                                                          Text(
                                                            DateFormat('yyyy/MM/dd').format(DateTime.parse(model.termList.termList[index].termTimeTo)),
                                                            style: TextStyle(fontSize: 18),
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
                                                  ],
                                                )
                                            )
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ProjectListInTermPage(termID: model.termList.termList[index].termID)),
                                          );
                                        },

                                      );

                                    }
                                ),
                              ),
                            ],
                          ),
                        );
                    } else return Center(child: CircularProgressIndicator());
                  }
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  bool isAdd = await model.createNewTerm();
                  if(isAdd) {
                    Fluttertoast.showToast(
                      msg: "Add new Term success",
                      textColor: Colors.green,
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Colors.white,
                      gravity: ToastGravity.CENTER,
                    );
                    model.loadTermList();
                    model.refresh();
                  } else {
                    Fluttertoast.showToast(
                      msg: "Add new Term fail",
                      textColor: Colors.red,
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Colors.white,
                      gravity: ToastGravity.CENTER,
                    );
                  }
                },
                label: Text("Add Term"),
                icon: Icon(Icons.add),
                backgroundColor: Colors.blue,
              ),
            );
          }
      ),
    );
  }


}