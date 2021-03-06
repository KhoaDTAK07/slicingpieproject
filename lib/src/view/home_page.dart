import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/model/sign_in_google_model.dart';
import 'package:slicingpieproject/src/view/companysetting_page.dart';
import 'package:slicingpieproject/src/view/list_term_history_page.dart';
import 'package:slicingpieproject/src/view/list_term_page.dart';
import 'package:slicingpieproject/src/view/loading_page.dart';
import 'package:slicingpieproject/src/view/login_page2.dart';
import 'package:slicingpieproject/src/view/not_found_page.dart';
import 'package:slicingpieproject/src/view/profile_page.dart';
import 'package:slicingpieproject/src/view/stakeHolder_add_page.dart';
import 'package:slicingpieproject/src/view/stakeHolder_detail_page.dart';
import 'package:slicingpieproject/src/viewmodel/company_setting_viewmodel.dart';
import 'package:slicingpieproject/src/viewmodel/company_switch_viewmodel.dart';
import 'package:slicingpieproject/src/viewmodel/home_page_viewmodel.dart';
import 'package:slicingpieproject/src/viewmodel/login_viewmodel2.dart';
import 'package:slicingpieproject/src/viewmodel/stakeHolder_add_viewmodel.dart';
import 'package:slicingpieproject/src/viewmodel/stakeHolder_detail_viewmodel.dart';
import 'package:slicingpieproject/src/viewmodel/term_list_viewmodel.dart';
import 'company_list_page.dart';

class HomePage extends StatelessWidget {
  final HomePageViewModel model;
  final String userToken;

  HomePage({Key key, @required this.model, this.userToken}) : super(key: key);

  String stakeHolderID, stakeHolderName;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomePageViewModel>(
      model: model,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          drawer: ScopedModelDescendant<HomePageViewModel>(
            builder: (context, child, model) {
              return Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountEmail: Text(model.stakeHolderName),
                      accountName: Text(model.stakeHolderID),
                      currentAccountPicture: new CircleAvatar(
                        backgroundColor: Colors.brown,
                        radius: 83.0,
                        child: ClipOval(
                          child: SizedBox(
                            child: Image.network(model.image),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onTap: () async {
                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        String stakeHolderID = sharedPreferences.getString("stakeHolderID");
                        print(stakeHolderID);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              model: StakeHolderDetailViewModel(stakeHolderID),
                            ),
                          ),
                        ).then((value) => model.loadListStakeHolderAfterChange());
                      },
                      leading: Icon(
                        Icons.account_circle,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'History Contribution Company',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListTermHistoryPage(
                              model: TermListViewModel(),
                            ),
                          ),
                        ).then((value) => model.loadListStakeHolderAfterChange());
                      },
                      leading: Icon(
                        Icons.supervisor_account,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Company Setting',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        if (userToken == null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompanySettingPage(
                                model: CompanySettingViewModel(),
                              ),
                            ),
                          ).then((value) => model.loadListStakeHolderAfterChange());
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompanySettingPage(
                                model: CompanySettingViewModel(),
                              ),
                            ),
                          ).then((value) => model.loadListStakeHolderAfterChange());
                        }
                      },
                      leading: Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Switch Company',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListCompanyPage(
                              model: CompanySwitchViewModel(),
                            ),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.swap_horiz,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onTap: () async {
                        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        await sharedPreferences.clear();
                        signOutGoogle();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            LoginPage2(LoginViewModel2())), (Route<dynamic> route) => false);
                      },
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          appBar: new AppBar(
            title: ScopedModelDescendant<HomePageViewModel>(
              builder: (context, child, model) {
                if (model.isLoading) {
                  return Text("");
                } else {
                  return Text(model.companyName);
                }
              },
            ),
            bottom: new TabBar(
                indicatorColor: Colors.blue,
                indicatorWeight: 2.0,
                tabs: [
                  Tab(text: "Overview"),
                  Tab(text: "Active"),
                  Tab(text: "InActive"),
                  Tab(text: "TermList"),
                ]),
          ),
          body: new TabBarView(
            children: [
              OverviewTab(),
              ActiveView(),
              InActiveView(),
              TermView(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StakeHolderAddPage(
                    model: StakeHolderAddViewModel(),
                  ),
                ),
              ).then((value) => model.loadListStakeHolderAfterChange());
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HomePageViewModel> (
      builder: (context, child, model) {
        if(model.isLoading) {
          return LoadingState();
        } else {
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: CircleAvatar(
                        radius: 110,
                        backgroundColor: Colors.greenAccent,
                        child: ClipOval(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.network(
                              model.overView.companyImage,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                      child: Text(
                        "Company Name: ",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                      child: Text(
                        model.overView.companyName,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                      child: Text(
                        "Total Slice: ",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                      child: Text(
                        model.overView.totalSlice.round().toString(),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                      child: Text(
                        "Cash per Slice: ",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                      child: Text(
                        model.overView.cashPerSlice.round().toString() + " VND",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                      child: Text(
                        "Total Term: ",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                      child: Text(
                        model.overView.totalTerm.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                      child: Text(
                        "Total StakeHolder: ",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                      child: Text(
                        model.overView.totalStakeHolder.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class TermView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HomePageViewModel>(
      builder: (context, child, model) {
        if (model.isLoading) {
          return LoadingState();
        } else if (model.termList == null) {
          return NotFoundPage();
        } else {
          return  Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: _drawSlidable(context, model),
          );
        }
      },
    );
  }

  Widget _drawSlidable(BuildContext context, HomePageViewModel model) {
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

  Widget _getListTerm(BuildContext context, int index, HomePageViewModel model) {
    return Column(
      children: <Widget>[
        GestureDetector(
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

class ActiveView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HomePageViewModel>(
      builder: (context, child, model) {
        if (model.isLoading) {
          return LoadingState();
        } else {
          return Container(
            child: ListView.builder(
              itemCount: model.stakeHolderList.stakeholderList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    print(model.stakeHolderList.stakeholderList[index].shID);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StakeHolderDetaiPage(
                          model: StakeHolderDetailViewModel(model
                              .stakeHolderList.stakeholderList[index].shID),
                        ),
                      ),
                    ).then((value) => model.loadListStakeHolderAfterChange());
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(140, 0, 0, 5),
                              child: CircleAvatar(
                                radius: 53.0,
                                child: CircleAvatar(
                                  radius: 50,
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 180,
                                      height: 180,
                                      child: Image.network(
                                        model.stakeHolderList
                                            .stakeholderList[index].shImage,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(165, 5, 0, 5),
                              child: Text(
                                model.stakeHolderList.stakeholderList[index]
                                    .shName,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(165, 0, 0, 15),
                              child: Text(
                                model.stakeHolderList.stakeholderList[index]
                                    .shJob,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Slice',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              model.stakeHolderList.stakeholderList[index]
                                  .sliceAssets
                                  .toStringAsFixed(2),
                              textAlign: TextAlign.left,
//                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: new LinearPercentIndicator(
                            animation: true,
                            lineHeight: 25.0,
                            animationDuration: 2000,
                            percent: (model.stakeHolderList
                                    .stakeholderList[index].sliceAssets /
                                model.getTotalSlice()),
                            center: Text(
                              ((model.stakeHolderList.stakeholderList[index]
                                                  .sliceAssets /
                                              model.getTotalSlice()) *
                                          100)
                                      .toStringAsFixed(2) +
                                  "%",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.greenAccent,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                          child: SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: RaisedButton(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListTermPage(
                                      model: TermListViewModel(),
                                      stakeHolderID: model.stakeHolderList
                                          .stakeholderList[index].shID,
                                      stakeHolderName: model.stakeHolderList
                                          .stakeholderList[index].shName,
                                    ),
                                  ),
                                ).then((value) =>
                                    model.loadListStakeHolderAfterChange());
                              },
                              child: Text(
                                'ADD CONTRIBUTION',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                            ),
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
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

class InActiveView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HomePageViewModel>(
      builder: (context, child, model) {
        if (model.isLoading) {
          return LoadingState();
        } else if (model.stakeHolderListInActive == null) {
          return NotFoundPage();
        } else {
          return Container(
            child: ListView.builder(
              itemCount: model.stakeHolderListInActive.stakeholderList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(140, 0, 0, 5),
                              child: CircleAvatar(
                                radius: 53.0,
                                child: CircleAvatar(
                                  radius: 50,
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 180,
                                      height: 180,
                                      child: Image.network(
                                        model.stakeHolderListInActive
                                            .stakeholderList[index].shImage,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(165, 5, 0, 5),
                              child: Text(
                                model.stakeHolderListInActive
                                    .stakeholderList[index].shName,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(165, 0, 0, 15),
                              child: Text(
                                model.stakeHolderListInActive
                                    .stakeholderList[index].shJob,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Slice',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              model.stakeHolderListInActive
                                  .stakeholderList[index].sliceAssets
                                  .toStringAsFixed(2),
                              textAlign: TextAlign.left,
//                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: new LinearPercentIndicator(
                            animation: true,
                            lineHeight: 25.0,
                            animationDuration: 2000,
//                            percent: (model.stakeHolderListInActive.stakeholderList[index]
//                                .sliceAssets /
//                                model.getTotalSlice()),
//                            center: Text(
//                              ((model.stakeHolderListInActive.stakeholderList[index].sliceAssets / model.getTotalSlice()) * 100).toStringAsFixed(2) + "%",
//                              style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
//                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.greenAccent,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                          child: SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: RaisedButton(
                              child: Text(
                                'ADD CONTRIBUTION',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              color: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                            ),
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
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
