import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/viewmodel/project_list_setting_viewmodel.dart';

class ProjectListSettingPage extends StatelessWidget {
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
        title: new Text("Project List Setting"),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {},
            color: Colors.blueAccent,
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
      body: BodyView(),
      floatingActionButton: BottomButton(),
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
              child: TextField(
                decoration: InputDecoration(
                    border: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                    ),
                    labelText: "Marketting"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
      backgroundColor: Colors.blue,
    );
  }

}
