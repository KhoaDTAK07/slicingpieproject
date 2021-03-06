import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/model/contribute-list-model.dart';
import 'package:slicingpieproject/src/repos/company-history-repo.dart';

class CompanyHistoryContributeViewModel extends Model {
  final CompanyHistoryRepo _repo = new CompanyHistoryRepoImp();

  List<ContributeListModel> _listContribute;

  List<ContributeListModel> get listContribute => _listContribute;

  int termId;
  String tokenUser;
  String companyID;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  CompanyHistoryContributeViewModel(int termID) {
    getAll(termID);
    termId = termID;
  }

  void getAll(int termID) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    tokenUser = sharedPreferences.getString("token");
    companyID = sharedPreferences.getString("companyID");

    _isLoading = true;
    notifyListeners();
    _listContribute =
        await _repo.listContribute(companyID, tokenUser, termID).whenComplete(() {
      _listContribute = listContribute;
      _isLoading = false;
    });
    notifyListeners();
  }

}
