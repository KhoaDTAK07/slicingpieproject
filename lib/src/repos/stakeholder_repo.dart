
import 'dart:convert';
import 'dart:io';

import 'package:slicingpieproject/src/helper/api_string.dart';
import 'package:slicingpieproject/src/model/stakeholder_model.dart';
import 'package:http/http.dart' as http;

abstract class StakeHolderRepo {
  Future<StakeHolderList> stakeHolderList (String tokenUser, String companyID);
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


}