import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/viewmodel/project_list_setting_viewmodel.dart';

class ListTermPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: const Icon(Icons.arrow_back), onPressed: () {});
          },
        ),
        title: new Text("List of Term"),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {},
            color: Colors.blueAccent,
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
      body: BodyView(),
    );
  }
}

class BodyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: TextField(
                decoration: InputDecoration(
                  border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black),
                  ),
                  labelText: "Term 1 \n 01/01/2020 - 31/03/2020",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
