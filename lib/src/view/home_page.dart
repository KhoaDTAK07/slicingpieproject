import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/view/companysetting_page.dart';
import 'package:slicingpieproject/src/view/list_term_page.dart';
import 'package:slicingpieproject/src/view/stakeHolder_add_page.dart';
import 'package:slicingpieproject/src/view/stakeHolder_detail_page.dart';
import 'package:slicingpieproject/src/viewmodel/company-history-contribute-vm.dart';
import 'package:slicingpieproject/src/viewmodel/company_setting_viewmodel.dart';
import 'package:slicingpieproject/src/viewmodel/home_page_viewmodel.dart';
import 'package:slicingpieproject/src/viewmodel/stakeHolder_add_viewmodel.dart';
import 'package:slicingpieproject/src/viewmodel/stakeHolder_detail_viewmodel.dart';
import 'package:slicingpieproject/src/viewmodel/term_list_viewmodel.dart';

import 'company-history-contribute-page.dart';

class HomePage extends StatelessWidget {
  final HomePageViewModel model;
  final String userToken;

  HomePage({Key key, @required this.model, this.userToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScopedModel<HomePageViewModel>(
          model: model,
          child: DefaultTabController(
            length: 2,
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
                            'Home',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          leading: Icon(
                            Icons.home,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Profile',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          leading: Icon(
                            Icons.account_circle,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'My History Contribution',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          leading: Icon(
                            Icons.history,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'History Contribution Company',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CompanyHistoryContributePage(
                                  companyHistory:
                                      CompanyHistoryContributeViewModel(),
                                ),
                              ),
                            );
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
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CompanySettingPage(
                                    model: CompanySettingViewModel(),
                                  ),
                                ),
                              );
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
                            Navigator.pop(context);
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
                          onTap: () {
                            Navigator.pop(context);
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
                    if(model.isLoading) {
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
                      new Tab(text: "Active"),
                      new Tab(text: "Inactive"),
                    ]),
              ),
              body: new TabBarView(
                children: [
                  ListViewHome(),
                  Icon(Icons.directions_transit),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async{
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  String tokenLogIn = sharedPreferences.getString("tokenLogIn");
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StakeHolderAddPage(
                        model: StakeHolderAddViewModel(),
                      ),
                    ),
                  ).then((value) => model.loadListStakeHolderByNormalSignIn(tokenLogIn));
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        ),
    );
  }
}

class ListViewHome extends StatelessWidget {
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
                  onTap: () async{
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    String stakeHolderID = sharedPreferences.getString("stakeHolderID");
                    String tokenLogIn = sharedPreferences.getString("tokenLogIn");

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StakeHolderDetaiPage(
                          model: StakeHolderDetailViewModel(model.stakeHolderList.stakeholderList[index].shID),
                        ),
                      ),
                    ).then((value) => model.loadListStakeHolderByNormalSignIn(tokenLogIn));
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
                                model
                                    .stakeHolderList.stakeholderList[index].shJob,
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
                              model.stakeHolderList.stakeholderList[index].sliceAssets.toStringAsFixed(2),
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,
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
                            percent: (model.stakeHolderList.stakeholderList[index]
                                    .sliceAssets /
                                model.getTotalSlice()),
                            center: Text(
                              ((model.stakeHolderList.stakeholderList[index].sliceAssets / model.getTotalSlice()) * 100).toStringAsFixed(2) + "%",
                              style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
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
                              onPressed: () {
                                Navigator.push(
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
                                );
                              },
                              child: Text(
                                'ADD CONTRIBUTION',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 18),
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

class LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
