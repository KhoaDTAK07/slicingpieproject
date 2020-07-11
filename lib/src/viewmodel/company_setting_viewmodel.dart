import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/model/company_model.dart';
import 'package:slicingpieproject/src/repos/company_detail_repo.dart';

class CompanySettingViewModel extends Model {
  CompanyRepo companyRepo = CompanyRepoImp();
  Company _company;
  String tokenUser;

  Company get company => _company;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  CompanySettingViewModel(String companyID) {
    loadCompanyDetail(companyID);
  }

  void loadCompanyDetail(String companyID) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    tokenUser = sharedPreferences.getString("token");
    _isLoading = true;
    notifyListeners();

    await companyRepo.companyDetail(companyID, tokenUser).whenComplete(() {
      _company = company;
      _isLoading = false;
      notifyListeners();
    });
  }

  void editCompanyDetail(String name, String icon, String noncash, String cash) async {
    String id = _company.id.toString();
    String oldname = name, oldicon = "", oldnoncash = noncash, oldcash = cash;
    int nonCash;
    int cashm;
    if (oldname == null) oldname = _company.name;
    if (oldicon == null) oldicon = _company.icon;
    if (oldnoncash == null) {
      nonCash = _company.nonMultiplayer;
    } else nonCash = int.parse(oldnoncash);
    print(nonCash);
    if (oldcash == null) {
      cashm = _company.multiplayer;
    }else cashm = int.parse(oldcash);

    _company = new Company(
        id: id,
        name: oldname,
        icon: oldicon,
        nonMultiplayer: nonCash,
        multiplayer: cashm);

    String json = jsonEncode(_company.toJson());

    _company = await companyRepo.updateCompany(id, json, tokenUser);

    loadCompanyDetail(_company.id);
  }

}