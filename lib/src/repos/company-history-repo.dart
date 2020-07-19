import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/helper/api_string.dart';

import 'package:http/http.dart' as http;
import 'package:slicingpieproject/src/model/company_contribution_detail_model.dart';
import 'package:slicingpieproject/src/model/contribute-list-model.dart';


abstract class CompanyHistoryRepo {
  Future<List<ContributeListModel>> listContribute(String companyID, String tokenUser);
  Future<ContributionDetailModel> contributionDetail(String assetID);
  Future<bool> updateContribution(String assetID, String updateJson);
}

class CompanyHistoryRepoImp implements CompanyHistoryRepo {
  @override
  Future<List<ContributeListModel>> listContribute(String companyID, String tokenUser) async {
    String apiGetList = APIString.apiGetContribution(companyID);
    Map<String, String> headersGet = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response responseGet = await http.get(apiGetList, headers: headersGet);
    print(responseGet.body);
    List<ContributeListModel> list;
    if (responseGet.statusCode == 200) {
      list = (json.decode(responseGet.body) as List)
          .map((data) => ContributeListModel.fromJson(data))
          .toList();
      return list;
    } else
      return list;

  }

  @override
  Future<ContributionDetailModel> contributionDetail(String assetID) async {
    print("------------");
    print(assetID);
    String apiGetContributionDetail = APIString.apiContributionDetail() + assetID;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String tokenUser = sharedPreferences.getString("token");

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.get(apiGetContributionDetail, headers: header);

    print(response.body);

    Map<String, dynamic> map = jsonDecode(response.body);

    ContributionDetailModel contributionDetailModel;
    contributionDetailModel = ContributionDetailModel.fromJson(map);

    return contributionDetailModel;
  }

  @override
  Future<bool> updateContribution(String assetID, String updateJson) async{
    String apiUpdate = APIString.apiUpdateContribution() + assetID;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String tokenUser = sharedPreferences.getString("token");

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.put(apiUpdate, headers: header, body: updateJson);

    bool isUpdated = true;

    if(response.statusCode == 204) {
      return isUpdated;
    } else {
      isUpdated = false;
      return isUpdated;
    }
  }

}