import 'dart:convert';
import 'dart:io';

import 'package:slicingpieproject/src/helper/api_string.dart';
import 'package:slicingpieproject/src/model/company_model.dart';
import 'package:http/http.dart' as http;

abstract class CompanyRepo {
  Future<Company> companyDetail(String companyID, String tokenUser);
  Future<Company> updateCompany(String companyID,String json, String tokenUser);
}

class CompanyRepoImp implements CompanyRepo{

  @override
  Future<Company> companyDetail(String companyID, String tokenUser) async {
    // TODO: implement companyDetail
    // API get Company Profile
    String apiGetCompanyProfile = APIString.apiCompanySetting(companyID);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };
    http.Response response = await http.get(apiGetCompanyProfile, headers: headers);
    Map<String, dynamic> list = jsonDecode(response.body);

    Company company;
    company = Company.fromJson(list);

    return company;
  }

  Future<Company> updateCompany(String companyID,String json, String tokenUser) async {
    String apiUpdateProfile = APIString.apiCompanySetting(companyID);
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.put(apiUpdateProfile,headers: header,body: json);

    print(response.body);
    Map<String, dynamic> company = jsonDecode(response.body);

    Company company1;
    company1 = Company.fromJson(company);

    return company1;
  }

}