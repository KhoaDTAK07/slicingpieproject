import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/helper/validate.dart';
import 'package:slicingpieproject/src/model/company_model.dart';
import 'package:slicingpieproject/src/repos/company_detail_repo.dart';
import 'package:path/path.dart' as path;

class CompanySettingViewModel extends Model {
  CompanyRepo companyRepo = CompanyRepoImp();

  TextEditingController _name = new TextEditingController();
  TextEditingController _nonMultiplayer = new TextEditingController();
  TextEditingController _multiplayer = new TextEditingController();
  TextEditingController _cashPerSlice = new TextEditingController();

  TextEditingController get name => _name;

  TextEditingController get nonMultiplayer => _nonMultiplayer;

  TextEditingController get multiplayer => _multiplayer;

  TextEditingController get cashPerSlice => _cashPerSlice;

  Company _company;

  Company get company => _company;

  String tokenUser;
  String companyID;

  //Valite ALL INPUT
  Validate _nameValid = Validate(null, null);
  Validate _nonMultiplayerValid = Validate(null, null);
  Validate _multiplayerValid = Validate(null, null);
  Validate _cashPerSliceValid = Validate(null, null);

  //Getters
  Validate get nameValid => _nameValid;

  Validate get nonMultiplayerValid => _nonMultiplayerValid;

  Validate get multiplayerValid => _multiplayerValid;

  Validate get cashPerSliceValid => _cashPerSliceValid;

  //Setters
  void changeName(String value) {
    if (value.length <= 3 || value.length > 20) {
      _nameValid =
          Validate(null, "Input Must Be > 3 character and < 20 character");
    } else {
      _nameValid = Validate(value, null);
    }
    notifyListeners();
  }

  //Setters
  void changeNonCash(String value) {
    var regex = r'^\d+$';
    RegExp regExp = new RegExp(regex);
    if (!regExp.hasMatch(value)) {
      _nonMultiplayerValid = Validate(null, "Input Must Be Integer");
    } else if (int.parse(value) > 10) {
      _nonMultiplayerValid = Validate(null, "Input Must < 10");
    } else {
      _nonMultiplayerValid = Validate(value, null);
    }
    notifyListeners();
  }

  //Setters
  void changeCash(String value) {
    var regex = r'^\d+$';
    RegExp regExp = new RegExp(regex);
    if (!regExp.hasMatch(value)) {
      _multiplayerValid = Validate(null, "Input Must Be Integer");
    } else if (int.parse(value) > 10) {
      _multiplayerValid = Validate(null, "Input Must < 10");
    } else {
      _multiplayerValid = Validate(value, null);
    }
    notifyListeners();
  }

  //Setters
  void changeCashPerSlice(String value) {
    var regex = r'^\d+$';
    RegExp regExp = new RegExp(regex);
    if (!regExp.hasMatch(value)) {
      _cashPerSliceValid = Validate(null, "Input Must Be Integer");
    } else if (int.parse(value) < 100000) {
      _cashPerSliceValid = Validate(null, "Input Must > 100000");
    } else {
      _cashPerSliceValid = Validate(value, null);
    }
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  File _image;

  File get image => _image;

  String _defaultImage;

  String get defaultImage => _defaultImage;

  bool _isReady = true;

  CompanySettingViewModel() {
    loadCompanyDetail();
  }

  Future loadCompanyDetail() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    tokenUser = sharedPreferences.getString("token");
    companyID = sharedPreferences.getString("companyID");

    _isLoading = true;
    notifyListeners();

    _company =
        await companyRepo.companyDetail(companyID, tokenUser).whenComplete(() {
      _company = company;
      _isLoading = false;
    });

    _name.text = company.name;
    _nameValid = Validate(company.name, null);
    _nonMultiplayer.text = company.nonMultiplayer.toString();
    _nonMultiplayerValid = Validate(company.nonMultiplayer.toString(), null);
    _multiplayer.text = company.multiplayer.toString();
    _multiplayerValid = Validate(company.multiplayer.toString(), null);
    _cashPerSlice.text =  company.cashPerSlice.toString();
    _cashPerSliceValid = Validate(company.cashPerSlice.toString(), null);
    _defaultImage = company.icon;

    notifyListeners();
  }

  void editCompanyDetail() async {
    _isReady = true;
    if (_nameValid.value == null) {
      changeName("");
      _isReady = false;
    }
    if (_multiplayerValid.value == null) {
      changeCash("");
      _isReady = false;
    }
    if (_nonMultiplayerValid.value == null) {
      changeNonCash("");
      _isReady = false;
    }
    if (_cashPerSliceValid.value == null) {
      changeCashPerSlice("");
      _isReady = false;
    }

    if (_isReady == true) {
      _isLoading = true;
      notifyListeners();
      String nowImage;
      if (_image != null) {
        var url = await upLoadImage();
        nowImage = url.toString();
      } else
        nowImage = defaultImage;

      Company companyModel = new Company(
          id: _company.id,
          name: _nameValid.value,
          icon: nowImage,
          nonMultiplayer: int.parse(_nonMultiplayerValid.value),
          multiplayer: int.parse(_multiplayerValid.value),
          cashPerSlice: double.parse(_cashPerSliceValid.value));

      String json = jsonEncode(companyModel.toJson());
      print(json);
      var company = await companyRepo.updateCompany(_company.id, json, tokenUser);

      if (company == null) {
        Fluttertoast.showToast(
          msg: "Is No Longer Available",
          textColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Edit Company Success",
          textColor: Colors.green,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      }
    }

    loadCompanyDetail();
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
}
