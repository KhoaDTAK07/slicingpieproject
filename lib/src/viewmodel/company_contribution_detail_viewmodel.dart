import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/helper/validation2.dart';
import 'package:slicingpieproject/src/model/company_contribution_detail_model.dart';
import 'package:slicingpieproject/src/model/project_model.dart';
import 'package:slicingpieproject/src/model/type_assets_model.dart';
import 'package:slicingpieproject/src/repos/company-history-repo.dart';
import 'package:slicingpieproject/src/repos/term_repo.dart';

class CompanyContributionDetailViewModel extends Model {
  CompanyHistoryRepo _repo = new CompanyHistoryRepoImp();
  TermRepo _termRepo = TermRepoImp();

  TypeAssetList _typeAssetList;
  TypeAssetList get typeAssetList => _typeAssetList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isReady = true;
  bool get isReady => _isReady;

  String _date;
  String get date => _date;

  ContributionDetailModel _contributionDetailModel;
  ContributionDetailModel get contributionDetailModel => _contributionDetailModel;

  TextEditingController stakeHolderNameController = new TextEditingController();
  TextEditingController assetIDController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController multiplierInTimeController = new TextEditingController();
  TextEditingController assetSliceController = new TextEditingController();
  TextEditingController companyIDController = new TextEditingController();
  TextEditingController projectIDController = new TextEditingController();
  TextEditingController typeAssetController = new TextEditingController();
  TextEditingController termIDController = new TextEditingController();

  CompanyContributionDetailViewModel(String assetID, String stakeHolderName) {
    getContributionDetail(assetID);
    stakeHolderNameController.text = stakeHolderName;
  }

  void getContributionDetail(String assetID) async{
    print("------------");
    print(assetID);
    _isLoading = true;
    notifyListeners();

    _contributionDetailModel = await _repo.contributionDetail(assetID);

    //Get asset list
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String companyID = sharedPreferences.getString("companyID");

    _typeAssetList = await _termRepo.getTypeAssetList(companyID);

    //Find and Set name of type asset based on _contributionDetailModel.typeAssetID
    for (int i = 0; i < _typeAssetList.typeAssetList.length; i++) {
      if(_typeAssetList.typeAssetList[i].typeAssetId == _contributionDetailModel.typeAssetID) {
        typeAssetController.text = _typeAssetList.typeAssetList[i].nameAsset;
      }
    }

    //set values to controllers
    if(_contributionDetailModel != null) {
      _contributionDetailModel = contributionDetailModel;
      _isLoading = false;

      _date = DateFormat('yyyy-MM-dd').format(DateTime.parse(_contributionDetailModel.timeAsset));

      assetIDController.text = _contributionDetailModel.assetID;
      quantityController.text = _contributionDetailModel.quantity.toString();
      descriptionController.text = _contributionDetailModel.description;
      multiplierInTimeController.text = _contributionDetailModel.multiplierInTime.toString();
      assetSliceController.text = _contributionDetailModel.assetSlice.toString();
      companyIDController.text = _contributionDetailModel.companyID;
      projectIDController.text = _contributionDetailModel.projectID;
      termIDController.text = _contributionDetailModel.termID;
      notifyListeners();
    }
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

  Future<bool> updateContribution() async {
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

      _contributionDetailModel = new ContributionDetailModel(
        assetID: assetIDController.text,
        quantity: double.parse(_quantity.value),
        description: _description.value,
        timeAsset: DateTime.now().toString(),
        multiplierInTime: int.parse(multiplierInTimeController.text),
        projectID: projectIDController.text,
        typeAssetID: _contributionDetailModel.typeAssetID,
        termID: termIDController.text,
        assetSlice: double.parse(assetSliceController.text),
        companyID: companyID,
        salaryGapInTime: 0,
        CashPerSlice: 0,
      );

      String updateJson = jsonEncode(_contributionDetailModel.toJson());
      print("--UpdateJson--");
      print(updateJson);

      return _repo.updateContribution(assetIDController.text, updateJson);
    }

  }

}