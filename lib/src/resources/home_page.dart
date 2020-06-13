import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slicingpieproject/src/model/stakeholder_model.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:slicingpieproject/src/viewmodel/login_viewmodel.dart';
import 'package:slicingpieproject/src/view/companysetting_page.dart';

class HomePage extends StatefulWidget {
  final StakeHolderList list;
  final String token;

  HomePage({Key key, this.list, this.token}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  String shName,shJob,shImage,companyID;
  double sliceAssets;
  Map<String, dynamic> company;

  final loginViewModel = LoginViewModel();

  Future<dynamic> getCompanyProfile() async {
    company = await loginViewModel.getCompanyProfile(widget.list.stakeholderList[0].companyID, widget.token);
    print(company);
  }

  @override
  Widget build(BuildContext context) {
    int length = widget.list.stakeholderList.length;

    double calculatedTotalSlice(){
      double totalSlice = 0;
      for (int i =0; i < length; i++){
        totalSlice += widget.list.stakeholderList[i].sliceAssets;
      }
      return totalSlice;
    };

    var totalSlice = calculatedTotalSlice();
    final formatter = new NumberFormat("(##,##%)");

    final tabController = new DefaultTabController(
        length: 2,
        child: new Scaffold(
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
                    getCompanyProfile().whenComplete(() => {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CompanySettingPage(company: company),
                        ),
                      ),
                    });
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
                ListView.builder(
                  itemCount: widget.list.stakeholderList.length,
                  itemBuilder: (BuildContext context, index){
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
                                        'https://media-exp1.licdn.com/dms/image/C4E03AQG7du-pU1O8kw/profile-displayphoto-shrink_200_200/0?e=1592438400&v=beta&t=GHaowcIAB7eDs5TlWiTKUqr1EXo_rBM1AsZh85AFcJg'
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
                                  widget.list.stakeholderList[index].shName,
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
                                  widget.list.stakeholderList[index].shJob,
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
                                flex: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(180, 0, 0, 0),
                                child: Text(
                                  widget.list.stakeholderList[index].sliceAssets.toString(),
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  formatter.format((widget.list.stakeholderList[index].sliceAssets / totalSlice) * 100),
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                  textAlign: TextAlign.right,
                                ),
                                flex: 50,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: new LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 50,
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 2000,
                              percent: (widget.list.stakeholderList[index].sliceAssets / totalSlice),
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
                        ],
                      ),
                    );
                  },
                ),

                Icon(Icons.directions_transit),
              ]
          ),
        ),
    );

    return new MaterialApp(
      home: tabController,
    );

  }
}