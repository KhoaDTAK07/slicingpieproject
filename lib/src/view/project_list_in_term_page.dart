import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/viewmodel/project_list_in_term_viewmodel.dart';

class ProjectListInTermPage extends StatelessWidget {
  final int termID;

  ProjectListInTermPage({Key key, @required this.termID}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProjectListInTermViewModel>(
      model: new ProjectListInTermViewModel(),
      child: ScopedModelDescendant<ProjectListInTermViewModel>(
          builder: (context, child, model) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('List of Project in Term'),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () async {
                       bool isSuccess = await model.endTerm(termID);
                        if(isSuccess) {
                          Fluttertoast.showToast(
                            msg: "Success",
                            textColor: Colors.green,
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.white,
                            gravity: ToastGravity.CENTER,
                          );
                          Navigator.of(context).pop();
                        } else {
                          Fluttertoast.showToast(
                            msg: "Fail",
                            textColor: Colors.red,
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.white,
                            gravity: ToastGravity.CENTER,
                          );
                        }
                      },
                      color: Colors.red,
                      child: Text(
                        "End Term",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              body: FutureBuilder(
                  future: model.loadData(termID),
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
                                    itemCount: model.list.projectList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return new GestureDetector(
                                        child: new ListTile(
                                            title: new Card(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    new ListTile(
                                                      title: Text(model.list.projectList[index].projectName),
                                                    ),
                                                  ],
                                                )
                                            )
                                        ),
                                        onTap: () {

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
                    showDialog(
                      context: context,
                      builder: (context) {
                        String contentText = "Content of Dialog";
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: new Text("Select project"),
                              content:  DropdownButton<String>(
                                items: model.projectName.map((String dropdownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropdownStringItem,
                                    child: Text(dropdownStringItem),
                                  );
                                }).toList(),
                                onChanged: (selectedValue) {
                                  model.changeSelectedProject(selectedValue);
                                  setState(() {
                                  });
                                },
                                value: model.project,
                                hint: Text(
                                  'Choose project',
                                  style: TextStyle(fontSize: 18),
                                ),
                                iconSize: 28,
                                elevation: 16,
                              ),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                new FlatButton(
                                  child: new Text("Add project"),
                                  onPressed: () async {
                                   bool isAdd = await model.addProject(termID);
                                   if(isAdd) {
                                     Fluttertoast.showToast(
                                       msg: "Add new Term success",
                                       textColor: Colors.green,
                                       toastLength: Toast.LENGTH_SHORT,
                                       backgroundColor: Colors.white,
                                       gravity: ToastGravity.CENTER,
                                     );
                                     Navigator.of(context).pop();
                                     model.loadData(termID);
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
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  label: Text("Add Project"),
                  icon: Icon(Icons.add),
                  backgroundColor: Colors.blue,
                )
            );
          }
      ),
    );
  }


}