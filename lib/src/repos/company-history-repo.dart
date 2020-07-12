import 'dart:convert';
import 'dart:io';

import 'package:slicingpieproject/src/helper/api_string.dart';

import 'package:http/http.dart' as http;
import 'package:slicingpieproject/src/model/contribute-list-model.dart';


abstract class CompanyHistoryRepo {
  Future<List<ContributeListModel>> listContribute(String companyID, String tokenUser);
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

}