import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/helper/validation2.dart';
import 'package:slicingpieproject/src/model/stakeholder_model.dart';
import 'package:slicingpieproject/src/repos/stakeholder_repo.dart';
import 'package:path/path.dart' as path;

class StakeHolderDetailViewModel extends Model {
  StakeHolderRepo _stakeHolderRepo = StakeHolderRepoImp();

  StakeHolder _stakeHolderDetailModel;
  StakeHolder get stakeHolderDetailModel => _stakeHolderDetailModel;

  StakeHolder _stakeHolderUpdateModel;
  StakeHolder get stakeHolderUpdateModel => _stakeHolderUpdateModel;

  bool _isLoading = false;
  bool _isReady = true;

  bool get isLoading => _isLoading;
  bool get isReady => _isReady;

  Validation2 _accountID = Validation2(null, null);
  Validation2 _shMarketSalary = Validation2(null, null);
  Validation2 _shSalary = Validation2(null, null);
  Validation2 _shJob = Validation2(null, null);
  Validation2 _shNameForCompany = Validation2(null, null);

  Validation2 get accountID => _accountID;
  Validation2 get shMarketSalary => _shMarketSalary;
  Validation2 get shSalary => _shSalary;
  Validation2 get shJob => _shJob;
  Validation2 get shNameForCompany => _shNameForCompany;

  TextEditingController accountIDField = new TextEditingController();
  TextEditingController shMarketSalaryField = new TextEditingController();
  TextEditingController shSalaryField = new TextEditingController();
  TextEditingController shJobField = new TextEditingController();
  TextEditingController shNameForCompanyField = new TextEditingController();

  File _image;
  File get image => _image;

  String _defaultImage;
  String get defaultImage => _defaultImage;

  void checkAccountID(String accountID) {
    print(accountID);
    if(accountID == null || accountID.length == 0){
      _accountID = Validation2(null, "AccountID can't be blank");
    } else {
      _accountID = Validation2(accountID, null);
    }
    notifyListeners();
  }

  void checkShMarketSalary(String shMarketSalary) {
    print(shMarketSalary);
    if(shMarketSalary == null || shMarketSalary.length == 0){
      _shMarketSalary = Validation2(null, "StakeHolder Market Salary can't be blank");
    }
    if(int.parse(shMarketSalary) <= 0){
      _shMarketSalary = Validation2(null, "StakeHolder Market Salary must be higher than 0");
    } else {
      _shMarketSalary = Validation2(shMarketSalary, null);
    }
    notifyListeners();
  }

  void checkShSalary(String shSalary) {
    print(shSalary);
    if(shSalary == null || shSalary.length == 0){
      _shSalary = Validation2(null, "StakeHolder Salary can't be blank");
    }
    if(int.parse(shSalary) <= 0){
      _shSalary = Validation2(null, "StakeHolder Salary must be higher than 0");
    } else {
      _shSalary = Validation2(shSalary, null);
    }
    notifyListeners();
  }

  void checkShJob(String shJob) {
    print(shJob);
    if(shJob == null || shJob.length == 0){
      _shJob = Validation2(null, "StakeHolder Job can't be blank");
    } else {
      _shJob = Validation2(shJob, null);
    }
    notifyListeners();
  }

  void checkShNameForCompany(String shNameForCompany) {
    print(shNameForCompany);
    if(shNameForCompany == null || shNameForCompany.length == 0){
      _shNameForCompany = Validation2(null, "StakeHolder Name for Company can't be blank");
    } else {
      _shNameForCompany = Validation2(shNameForCompany, null);
    }
    notifyListeners();
  }

  Future getMyImage() async {
    var pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
    notifyListeners();
  }

  Future<String> upLoadImage() async {
    String basename = path.basename(_image.path);
    StorageReference reference = FirebaseStorage.instance.ref().child(basename);
    StorageUploadTask uploadTask = reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await reference.getDownloadURL();
    return url;
  }

  StakeHolderDetailViewModel(String accountID) {
    loadStakeHolderDetail(accountID);
  }

  void loadStakeHolderDetail(String accountID) async {
    _isLoading = true;

    notifyListeners();

    _stakeHolderDetailModel = await _stakeHolderRepo.getStakeHolderDetail(accountID);

    if(_stakeHolderDetailModel != null) {
      _stakeHolderDetailModel = stakeHolderDetailModel;

      accountIDField.text =  _stakeHolderDetailModel.shID;
      shMarketSalaryField.text = _stakeHolderDetailModel.shMarketSalary.toString();
      shSalaryField.text = _stakeHolderDetailModel.shSalary.toString();
      shJobField.text = _stakeHolderDetailModel.shJob;
      shNameForCompanyField.text = _stakeHolderDetailModel.shNameForCompany;
      _defaultImage = _stakeHolderDetailModel.shImage;

      _accountID = Validation2(_stakeHolderDetailModel.shID, null);
      _shMarketSalary = Validation2(_stakeHolderDetailModel.shMarketSalary.toString(), null);
      _shSalary = Validation2(_stakeHolderDetailModel.shSalary.toString(), null);
      _shJob = Validation2(_stakeHolderDetailModel.shJob, null);
      _shNameForCompany = Validation2(_stakeHolderDetailModel.shNameForCompany, null);

      _isLoading = false;
      notifyListeners();
    }

  }

  Future<bool> updateStakeHolder() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String companyID = sharedPreferences.getString("companyID");
    _isReady = true;

    if(_shMarketSalary.value == null) {
      print(_shMarketSalary.value);
      checkShMarketSalary(null);
      _isReady = false;
    }
    if(_shSalary.value == null) {
      print(_shSalary.value);
      checkShSalary(null);
      _isReady = false;
    }
    if(_shJob.value == null) {
      print(_shJob.value);
      checkShJob(null);
      _isReady = false;
    }
    if(_shNameForCompany.value == null) {
      print(_shNameForCompany.value);
      checkShNameForCompany(null);
      _isReady = false;
    }
    if(double.parse(_shMarketSalary.value) < double.parse(_shSalary.value)) {
      print("Market salary must be higher than salary");
      checkShMarketSalary(null);
      checkShSalary(null);
      _isReady = false;
    }

    if(_isReady == true) {
      _isLoading = true;
      notifyListeners();

      String currentImage;
      if(_image != null) {
        var url = await upLoadImage();
        currentImage = url.toString();
      } else {
        currentImage = defaultImage;
      }

      _stakeHolderUpdateModel = new StakeHolder(
        shID: accountIDField.text,
        companyID: companyID,
        shMarketSalary: double.parse(_shMarketSalary.value),
        shSalary: double.parse(_shSalary.value),
        shJob: _shJob.value,
        shNameForCompany: _shNameForCompany.value,
        shImage: currentImage,
        shStatus: "abc",
        shRole: 0,
      );

      String updateJson = jsonEncode(_stakeHolderUpdateModel.toJson());

      return _stakeHolderRepo.updateStakeHolder(accountIDField.text, updateJson);
    }
  }

}