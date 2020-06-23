import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/model/company_model.dart';
import 'package:slicingpieproject/src/repos/company_detail_repo.dart';

class CompanySettingViewModel extends Model {
  String token;
  CompanyRepo companyRepo = CompanyRepoImp();
  Company _company;

  Company get company => _company;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  CompanySettingViewModel(String companyID, String tokenUser) {
    loadCompanyDetail(companyID, tokenUser);
  }

  void loadCompanyDetail(String companyID, String tokenUser) async {
    token = tokenUser;
    _isLoading = true;
    notifyListeners();
    _company =
        await companyRepo.companyDetail(companyID, tokenUser).whenComplete(() {
      _company = company;
      _isLoading = false;
      notifyListeners();
    });
  }

  void editCompanyDetail(
      String name, String icon, String noncash, String cash) async {
    String id = _company.id.toString();
    String oldname = name, oldicon = "", oldnoncash = noncash, oldcash = cash;
    int nonCash;
    int cashm;
    if (oldname == null) oldname = _company.name;
    if (oldicon == null) oldicon = _company.icon;
    if (oldnoncash == null) {
      nonCash = _company.nonMultiplayer;
    }
    if (oldcash == null) {
      cashm = _company.multiplayer;
    }

    _company = new Company(
        id: id,
        name: oldname,
        icon: oldicon,
        nonMultiplayer: nonCash,
        multiplayer: cashm);

    String json = jsonEncode(_company.toJson());

    _company = await companyRepo.updateCompany(id, json, token);

    loadCompanyDetail(_company.id, token);
  }
}
