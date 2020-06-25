import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/view/companysetting_page.dart';
import 'package:slicingpieproject/src/viewmodel/company_setting_viewmodel.dart';
import 'package:slicingpieproject/src/viewmodel/home_page_viewmodel.dart';


class HomePage extends StatelessWidget{
  final HomePageViewModel model;
  final String userToken;

  HomePage({Key key, @required this.model, this.userToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: ScopedModel<HomePageViewModel>(
            model: model,
            child: Scaffold(
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Text('John'),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Home',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        'View Contribution',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      leading: Icon(
                        Icons.pie_chart,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'History Contribution',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        'Company Setting',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        if(userToken == null){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CompanySettingPage(model: CompanySettingViewModel(model.stakeHolderList.stakeholderList[0].companyID, model.userToken),),
                            ),
                          );
                        } else {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CompanySettingPage(model: CompanySettingViewModel(model.stakeHolderList.stakeholderList[0].companyID, userToken),),
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
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              ),
              appBar: new AppBar(
                title: new Text("Bug Company"),
                bottom: new TabBar(
                    indicatorColor: Colors.blue,
                    indicatorWeight: 2.0,
                    tabs: [
                      new Tab(text: "Active"),
                      new Tab(text: "Inactive"),
                    ]
                ),
              ),
              body: new TabBarView(
                  children: [
                    ListViewHome(),

                    Icon(Icons.directions_transit),
                  ]
              ),
            ),
          ),
        ),
      );
  }

}

class ListViewHome extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HomePageViewModel>(
      builder: (context, child, model) {
        if(model.isLoading){
          return LoadingState();
        } else {
          return Container(
            child: ListView.builder(
              itemCount: model.stakeHolderList.stakeholderList.length,
              itemBuilder: (context, index){
                return Container(
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
                                backgroundImage: NetworkImage(
                                    ''
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
                              model.stakeHolderList.stakeholderList[index].shName,
                              style: TextStyle(fontSize: 18, color: Colors.black,),
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
                              model.stakeHolderList.stakeholderList[index].shJob,
                              style: TextStyle(fontSize: 18, color: Colors.black,),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Slice',
                              style: TextStyle(fontSize: 18, color: Colors.black,),
                            ),
                            flex: 75,
                          ),
                          Expanded(
                            child: Text(
                              model.stakeHolderList.stakeholderList[index].sliceAssets.toString(),
                              style: TextStyle(fontSize: 18, color: Colors.black,),
                            ),
                            flex: 25,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: new LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 50,
                          animation: true,
                          lineHeight: 25.0,
                          animationDuration: 2000,
                          percent: (model.stakeHolderList.stakeholderList[index].sliceAssets / model.getTotalSlice()),
                          center: Text(model.getFormat((model.stakeHolderList.stakeholderList[index].sliceAssets / model.getTotalSlice()) * 100)),
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
                            onPressed: () {},
                            child: Text(
                              'ADD CONTRIBUTION',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
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
                );
              },
            ),
          );
        }
      }
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


