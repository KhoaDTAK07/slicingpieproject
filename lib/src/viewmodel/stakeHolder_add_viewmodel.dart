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

class StakeHolderAddViewModel extends Model {
  StakeHolderRepo _stakeHolderRepo = StakeHolderRepoImp();
  StakeHolder _stakeHolder;

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

  TextEditingController stakeHolderNameField = new TextEditingController();

  File _image;
  File get image => _image;

  String _defaultImage = "https://firebasestorage.googleapis.com/v0/b/swdslicingpie-59d47.appspot.com/o/noimage.jpg?alt=media&token=0c5a62f3-d5e6-4983-942a-085761d66567";
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

  Future<dynamic> addStakeHolder() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String companyID = sharedPreferences.getString("companyID");

    _isReady = true;

    if(_accountID.value == null) {
      print(_accountID.value);
      checkAccountID(null);
      _isReady = false;
    }
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
    if(_shNameForCompany.value == null) {
      print(_shNameForCompany.value);
      checkShNameForCompany(null);
      _isReady = false;
    }
    if(_shJob.value == null) {
      print(_shJob.value);
      checkShJob(null);
      _isReady = false;
    }
    if(_isReady == true) {
      _isLoading = true;
      notifyListeners();

      String nowImage;
      if (_image != null) {
        var url = await upLoadImage();
        nowImage = url.toString();
      } else {
        nowImage = defaultImage;
      }

      _stakeHolder = new StakeHolder(
        shID: _accountID.value,
        companyID: companyID,
        shMarketSalary: int.parse(_shMarketSalary.value),
        shSalary: int.parse(_shSalary.value),
        shJob: _shJob.value,
        shNameForCompany: _shNameForCompany.value,
        shImage: nowImage,
        shStatus: "abc",
        shRole: 0,
      );

      String addJson = jsonEncode(_stakeHolder.toJson());

      print("--Add Json--");
      print(addJson);

      return _stakeHolderRepo.addStakeHolder(addJson);
    }
  }
}