import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/helper/api_string.dart';
import 'package:http/http.dart' as http;

abstract class AddContributionRepo {
  Future<bool> addContribution(String addJson, String stakeHolderID);
}

class AddContributionRepoImp implements AddContributionRepo {

  @override
  Future<bool> addContribution(String addJson, String stakeHolderID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String companyID = sharedPreferences.getString("companyID");
    String tokenUser = sharedPreferences.getString("token");

    String apiAddContribution = APIString.apiAddContribution(companyID, stakeHolderID);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.post(apiAddContribution, headers: headers, body: addJson);
    print(response.body);
    bool isAdded;

    if(response.statusCode == 204) {
      isAdded = true;
      return isAdded;
    } else {
      isAdded = false;
      return isAdded;
    }

  }

}