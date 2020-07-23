import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/helper/api_string.dart';
import 'package:slicingpieproject/src/model/company_model.dart';
import 'package:http/http.dart' as http;

abstract class CompanySwitchRepo {
  Future<CompanyList> getListCompany();

  Future<dynamic> switchCompany(String companyID);
}

class CompanySwitchRepoImp implements CompanySwitchRepo {

  @override
  Future<CompanyList> getListCompany() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String accountID = sharedPreferences.getString("stakeHolderID");
    String companyID = sharedPreferences.getString("companyID");
    String tokenUser = sharedPreferences.getString("token");

    String apiGetListCompany = APIString.apiGetListCompany(companyID, accountID);

    Map<String, String> headersGet = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.get(apiGetListCompany, headers: headersGet);
    print(accountID);
    print(companyID);
    print(response.body);
    List<dynamic> list = jsonDecode(response.body);

    CompanyList companyList;
    companyList = CompanyList.fromJson(list);
    return companyList;
  }

  @override
  Future<dynamic> switchCompany(String companyID) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accountID = sharedPreferences.getString("stakeHolderID");
    String tokenUser = sharedPreferences.getString("token");

    String apiSwitchCompany = APIString.apiSwitchCompany(companyID, accountID);

    print(companyID);
    print(accountID);

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    print(apiSwitchCompany);

    http.Response response = await http.post(apiSwitchCompany, headers: header);
    print(response.body);

    int statusCode = response.statusCode;
    print("Status Code: " + statusCode.toString());

    if(statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json;

    } else {
      Map<String, dynamic> map = new Map<String,dynamic>();
      map['StatusCode'] = 401;
      return map;
    }
  }

}