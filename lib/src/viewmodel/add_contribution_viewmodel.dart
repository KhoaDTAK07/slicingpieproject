import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/helper/validation2.dart';
import 'package:slicingpieproject/src/model/add_contribution_model.dart';
import 'package:slicingpieproject/src/model/project_model.dart';
import 'package:slicingpieproject/src/model/type_assets_model.dart';
import 'package:slicingpieproject/src/repos/add_contribution_repo.dart';
import 'package:slicingpieproject/src/repos/term_repo.dart';

class AddContributionViewmodel extends Model {
  AddContributionRepo _addContributionRepo = AddContributionRepoImp();
  TermRepo _termRepo = TermRepoImp();
  ProjectList _projectList;
  String accountID;
  int termId;

  ProjectList get projectList => _projectList;

  List<String> _projectName = [];

  List<String> get projectName => _projectName;

  List<String> _typeContribute = [];

  List<String> get typeContribute => _typeContribute;

  TypeAssetList _assetList;

  TypeAssetList get assetList => _assetList;

  AddContributionModel _addContributionModel;

  String _idProject;

  String _selectedProject;

  String get selectedProject => _selectedProject;

  int _idTypeContribute;

  String _selectedTypeContribute;

  String get selectedTypeContribute => _selectedTypeContribute;

  AddContributionViewmodel(String stakeHolderName, int termID) {
    loadAccount(stakeHolderName, termID);
    accountID = stakeHolderName;
    termId = termID;
  }

  void loadAccount(String stakeHolderName, int termID) async {
    accountFieldController.text = stakeHolderName;
    _projectList =
    await _termRepo.getProjectList(termID.toString()).whenComplete(() {
      _projectList = projectList;
      _isLoading = false;
    });

    for (int i = 0; i < _projectList.projectList.length; i++) {
      _projectName.add(projectList.projectList[i].projectName);
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String companyID = sharedPreferences.getString("companyID");

    _assetList = await _termRepo.getTypeAssetList(companyID);

    for (int i = 0; i < _assetList.typeAssetList.length; i++) {
      _typeContribute.add(_assetList.typeAssetList[i].nameAsset);
    }

    notifyListeners();
  }

  void changeSelectedProject(String newValue) {
    _selectedProject = newValue;
    _idProject = _projectList.projectList[_projectName.indexOf(newValue)].projectID;
    print(_idProject);
    notifyListeners();
  }

  void changeSelectedTypeAsset(String newValue) {
    _selectedTypeContribute = newValue;
    _idTypeContribute = _assetList.typeAssetList[_typeContribute.indexOf(newValue)].typeAssetId;
    print(_idTypeContribute);
    notifyListeners();
  }

  TextEditingController accountFieldController = TextEditingController();

  bool _isLoading = false;
  bool _isReady = true;

  bool get isLoading => _isLoading;

  bool get isReady => _isReady;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  String _selectedDateFormat = DateFormat('yyyy-MM-dd').format(DateTime.now());

  String get selectedDateFormat => _selectedDateFormat;

  set selectedDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    _selectedDateFormat = DateFormat('yyyy-MM-dd').format(_selectedDate);
    notifyListeners();
  }

  Validation2 _description = Validation2(null, null);
  Validation2 _quantity = Validation2(null, null);


  Validation2 get description => _description;
  Validation2 get quantity => _quantity;

  void checkDescription(String description) {
    print(description);
    if(description == null || description.length == 0){
      _description = Validation2(null, "Description can't be blank");
    } else {
      _description = Validation2(description, null);
    }
    notifyListeners();
  }

  void checkQuantity(String quantity) {
    if(quantity == null || quantity.length == 0){
      _quantity = Validation2(null, "Quantity can't be blank");
    }
    if(int.parse(quantity) <= 0){
      _quantity = Validation2(null, "Quantity must be higher than 0");
    } else {
      _quantity = Validation2(quantity, null);
    }
    notifyListeners();
  }

  Future<bool> addContribution() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String companyID = sharedPreferences.getString("companyID");

    _isReady = true;
    if(_description.value == null) {
      print("----Description---");
      print(_description.value);
      checkDescription(null);
      _isReady = false;
    }
    if(_quantity.value == null) {
      print("----Quantity---");
      print(_quantity.value);
      checkQuantity(null);
      _isReady = false;
    }
    if(_isReady = true){
      _isLoading = true;
      notifyListeners();

      _addContributionModel = new AddContributionModel(
        description: _description.value,
        projectID: _idProject,
        companyID: companyID,
        accountID: accountID,
        quantity: int.parse(_quantity.value),
        termID: termId,
        timeAsset: _selectedDate.toString(),
        typeAssetID: _idTypeContribute.toString()
      );

      String addJson = jsonEncode(_addContributionModel.toJson());
      print("--Add Json--");
      print(addJson);

      return _addContributionRepo.addContribution(addJson, accountID);
    }
  }

}
