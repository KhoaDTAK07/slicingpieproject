import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/view/add_contribution_page.dart';
import 'package:slicingpieproject/src/view/company-history-contribute-page.dart';
import 'package:slicingpieproject/src/view/companysetting_page.dart';
import 'package:slicingpieproject/src/viewmodel/add_contribution_viewmodel.dart';
import 'package:slicingpieproject/src/viewmodel/company-history-contribute-vm.dart';
import 'package:slicingpieproject/src/viewmodel/term_list_viewmodel.dart';

class ListTermHistoryPage extends StatelessWidget {
  final TermListViewModel model;

  ListTermHistoryPage({this.model});

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

  Widget _getListTerm(
      BuildContext context, int index, TermListViewModel model) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CompanyHistoryContributePage(
                      companyHistory: CompanyHistoryContributeViewModel(model.termList.termList[index].termID),
                    ),
              ),
            ).then((value) => model.loadTermList());
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
