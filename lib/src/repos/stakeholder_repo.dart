
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/helper/api_string.dart';
import 'package:slicingpieproject/src/model/stakeholder_model.dart';
import 'package:http/http.dart' as http;

abstract class StakeHolderRepo {
  Future<StakeHolderList> stakeHolderList (String tokenUser, String companyID);
  Future<bool> addStakeHolder(String addJson);
  Future<StakeHolder> getStakeHolderDetail(String accountID);
}

class StakeHolderRepoImp implements StakeHolderRepo {

  @override
  Future<StakeHolderList> stakeHolderList(String tokenUser, String companyID) async {
    // TODO: implement stakeHolderListByCompanyID

    String apiGetList = APIString.apiGetListStakeHolder(companyID);
    Map<String, String> headersGet = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response responseGet = await http.get(apiGetList, headers: headersGet);
    print("------------");
    print(responseGet.body);

    List<dynamic> list = jsonDecode(responseGet.body);

    StakeHolderList stakeHolderList;
    stakeHolderList = StakeHolderList.fromJson(list);
//    print(stakeHolderList.stakeholderList.length);

    return stakeHolderList;
  }

  @override
  Future<bool> addStakeHolder(String addJson) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String companyID = sharedPreferences.getString("companyID");
    String tokenUser = sharedPreferences.getString("token");

    String apiAdd = APIString.apiAddStakeHolder() + companyID;

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.post(apiAdd, headers: header, body: addJson);

    print(response.body);

    if(response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
    
  }

  @override
  Future<StakeHolder> getStakeHolderDetail(String accountID) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String companyID = sharedPreferences.getString("companyID");
    String tokenUser = sharedPreferences.getString("token");

    String apiGetDetail = APIString.apiGetStakeHolderDetail() + companyID + "/" + accountID;

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.get(apiGetDetail, headers: header);
    Map<String, dynamic> map = json.decode(response.body);

    StakeHolder stakeHolder;
    stakeHolder = StakeHolder.fromJsonDetail(map);

    return stakeHolder;
  }


}