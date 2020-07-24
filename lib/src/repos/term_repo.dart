import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/helper/api_string.dart';
import 'package:slicingpieproject/src/model/project_model.dart';
import 'package:slicingpieproject/src/model/term_model.dart';
import 'package:slicingpieproject/src/model/type_assets_model.dart';
import 'package:http/http.dart' as http;

abstract class TermRepo {
  Future<TermList> getTermList(String companyID);
  Future<ProjectList> getProjectList(String termID);
  Future<TypeAssetList> getTypeAssetList(String companyID);
  Future<bool> createNewTerm(String companyID);
  Future<bool> endTerm(int termID);
}

class TermRepoImp implements TermRepo {

  @override
  Future<TermList> getTermList(String companyID) async {
    String apiGetTermList = APIString.apiGetListTerm(companyID);
    print(companyID);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String tokenUser = sharedPreferences.getString("token");
    print(tokenUser);

    Map<String, String> headersGet = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.get(apiGetTermList, headers: headersGet);

    print(response.body);
    List<dynamic> list = jsonDecode(response.body);

    TermList termList;
    termList = TermList.fromJson(list);

    return termList;
  }

  @override
  Future<ProjectList> getProjectList(String termID) async {
    String apiGetProjectList = APIString.apiGetProjectListInTerm(termID);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String tokenUser = sharedPreferences.getString("token");

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.get(apiGetProjectList, headers: header);

    List<dynamic> list = jsonDecode(response.body);

    ProjectList projectList;
    projectList = ProjectList.fromJson(list);

    return projectList;
  }

  @override
  Future<TypeAssetList> getTypeAssetList(String companyID) async{
    String apiGetTypeAssetList = APIString.apiGetListAssetInCompany(companyID);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String tokenUser = sharedPreferences.getString("token");

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.get(apiGetTypeAssetList, headers: header);

    List<dynamic> list = jsonDecode(response.body);

    TypeAssetList assetList;
    assetList = TypeAssetList.fromJson(list);

    return assetList;
  }

  @override
  Future<bool> createNewTerm(String companyID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String tokenUser = sharedPreferences.getString("token");
    Map<String, String> map = Map();
    map["TermTimeFrom"] = DateTime.now().toString();
    map["TermTimeTo"] = DateTime.now().toString();
    map["CompanyId"] = companyID;
    map["TermName"] = "Junk";

    String json = jsonEncode(map);

    String apiCreateTerm = APIString.apiCreateTermInCompany(companyID);
    print(apiCreateTerm);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.post(apiCreateTerm, headers: headers, body: json);
    bool isAdded;
      print(response.body);
    if(response.statusCode == 204) {
      isAdded = true;
      return isAdded;
    } else {
      isAdded = false;
      return isAdded;
    }

  }

  @override
  Future<bool> endTerm(int termID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String tokenUser = sharedPreferences.getString("token");
    String apiEndTerm = APIString.apiEndTerm(termID);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.put(apiEndTerm, headers: headers);
    bool isSuccess;
    print(response.statusCode);
    if(response.statusCode == 204) {
      isSuccess = true;
      return isSuccess;
    } else {
      isSuccess = false;
      return isSuccess;
    }
  }

}