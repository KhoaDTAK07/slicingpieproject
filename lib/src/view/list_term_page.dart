import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/view/add_contribution_page.dart';
import 'package:slicingpieproject/src/view/companysetting_page.dart';
import 'package:slicingpieproject/src/view/loading_page.dart';
import 'package:slicingpieproject/src/view/not_found_page.dart';
import 'package:slicingpieproject/src/viewmodel/add_contribution_viewmodel.dart';
import 'package:slicingpieproject/src/viewmodel/term_list_viewmodel.dart';

class ListTermPage extends StatelessWidget {
  final TermListViewModel model;
  final String stakeHolderID, stakeHolderName;

  ListTermPage({this.model, this.stakeHolderID, this.stakeHolderName});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<TermListViewModel>(
      model: model,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text(
            "List Of Term",
            textAlign: TextAlign.center,
          ),
        ),
        body: GestureDetector(
          child: Column(
            children: <Widget>[
              ScopedModelDescendant<TermListViewModel>(
                  builder: (context, child, model) {
                if (model.isLoading) {
                  return LoadingState();
                } else if (model.termList.termList.isEmpty){
                  return NotFoundPage();
                } else {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: _drawSlidable(context, model),
                    ),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawSlidable(BuildContext context, TermListViewModel model) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: model.termList.termList.length,
      itemBuilder: (context, index) {
        return Slidable(
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.5,
          child: _getListTerm(context, index, model),
        );
      },
    );
  }

  Widget _getListTerm(BuildContext context, int index, TermListViewModel model) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            if (model.termList.termList[index].termStatus == "1") {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddContributionPage(
                      model: AddContributionViewmodel(stakeHolderName,
                          stakeHolderID, model.termList.termList[index].termID),
                      dateFrom: model.termList.termList[index].termTimeFrom,
                      dateTo: model.termList.termList[index].termTimeTo,
                    ),
                  )).then((value) => Navigator.of(context).pop());
            } else {
              Fluttertoast.showToast(
                msg: "Sorry, Term already closed!",
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.red,
                gravity: ToastGravity.CENTER,
              );
            }
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      model.termList.termList[index].termName +
                          " - " +
                          ((model.termList.termList[index].termSlice / model.getTotalSlice()) * 100).toStringAsFixed(2) + "%",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    if (model.termList.termList[index].termStatus == "1")
                      Text(
                        "Active",
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      )
                    else
                      Text(
                        "InActive",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      DateFormat('yyyy/MM/dd').format(DateTime.parse(
                          model.termList.termList[index].termTimeFrom)),
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(" - "),
                    Text(
                      DateFormat('yyyy/MM/dd').format(DateTime.parse(
                          model.termList.termList[index].termTimeTo)),
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
          ),
        ),
      ],
    );
  }
}
