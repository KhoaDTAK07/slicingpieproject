import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/viewmodel/project_list_viewmodel.dart';

import 'loading_page.dart';

class ProjectListPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProjectListViewModel>(
      model: new ProjectListViewModel(),
      child: ScopedModelDescendant<ProjectListViewModel>(
          builder: (context, child, model) {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text('List of Project'),
                ),
                body: FutureBuilder(
                    future: model.loadData(),
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
                                            model.newProject = model.list.projectList[index].projectName;
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                // return object of type Dialog
                                                return AlertDialog(
                                                  content: Stack(
                                                    overflow: Overflow.visible,
                                                    children: <Widget>[
                                                      Positioned(
                                                        right: -40.0,
                                                        top: -40.0,
                                                        child: InkResponse(
                                                          onTap: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: CircleAvatar(
                                                            child: Icon(Icons.close),
                                                            backgroundColor: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                      Form(
                                                        key: _formKey,
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: <Widget>[
                                                            Padding(
                                                                padding: EdgeInsets.all(8.0),
                                                                child:
                                                                Text('Name of project')
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child:
                                                              TextFormField(
                                                                initialValue: model.list.projectList[index].projectName,
                                                                onChanged: (value) {
                                                                  model.newProject = value;
                                                                },
                                                                validator: (value) {
                                                                  if (value == null || value.isEmpty) return 'Name is required.';
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: RaisedButton(
                                                                child: Text("Update"),
                                                                onPressed: () async {
                                                                  if (_formKey.currentState.validate()) {
                                                                    bool isUpdate = await model.updateProject(model.list.projectList[index].projectID);
                                                                    if(isUpdate) {
                                                                      Navigator.of(context).pop();
                                                                      Fluttertoast.showToast(
                                                                        msg: "Update Project success",
                                                                        textColor: Colors.green,
                                                                        toastLength: Toast.LENGTH_SHORT,
                                                                        backgroundColor: Colors.white,
                                                                        gravity: ToastGravity.CENTER,
                                                                      );
                                                                      model.loadData();
                                                                      model.refresh();
                                                                    } else {
                                                                      Fluttertoast.showToast(
                                                                        msg: "Update Project fail",
                                                                        textColor: Colors.red,
                                                                        toastLength: Toast.LENGTH_SHORT,
                                                                        backgroundColor: Colors.white,
                                                                        gravity: ToastGravity.CENTER,
                                                                      );
                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      content: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Positioned(
                            right: -40.0,
                            top: -40.0,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child:
                                 Text('Name of project')
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child:
                                      TextFormField(
                                        onChanged: (value) {
                                          model.newProject = value;
                                        },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return 'Name is required.';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    child: Text("Create"),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        bool isAdd = await model.addNewProject();
                                        if(isAdd) {
                                          Navigator.of(context).pop();
                                          Fluttertoast.showToast(
                                            msg: "Add Project success",
                                            textColor: Colors.green,
                                            toastLength: Toast.LENGTH_SHORT,
                                            backgroundColor: Colors.white,
                                            gravity: ToastGravity.CENTER,
                                          );
                                          model.loadData();
                                          model.refresh();
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: "Add Project fail",
                                            textColor: Colors.red,
                                            toastLength: Toast.LENGTH_SHORT,
                                            backgroundColor: Colors.white,
                                            gravity: ToastGravity.CENTER,
                                          );
                                        }
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
                  },
                  label: Text("Add Project"),
                  icon: Icon(Icons.add),
                  backgroundColor: Colors.blue,
                ),
              );
            }
      ),
    );
  }


}