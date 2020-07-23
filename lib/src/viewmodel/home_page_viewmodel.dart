import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/model/stakeholder_model.dart';
import 'package:slicingpieproject/src/model/term_model.dart';
import 'package:slicingpieproject/src/model/user_login_detail_model.dart';
import 'package:slicingpieproject/src/repos/stakeholder_repo.dart';
import 'package:slicingpieproject/src/repos/user_login_detail_repo.dart';

class HomePageViewModel extends Model {
  UserDetailRepo _userDetailRepo = UserDetailRepoImp();
  StakeHolderRepo _stakeHolderRepo = StakeHolderRepoImp();

  String _image, _stakeHolderID, _stakeHolderName, _companyName;

  String get image => _image;
  String get stakeHolderID => _stakeHolderID;
  String get stakeHolderName => _stakeHolderName;
  String get companyName => _companyName;

  StakeHolderList _stakeHolderList;
  TermList _termList;
  bool _isLoading = false;

  StakeHolderList get stakeHolderList => _stakeHolderList;
  TermList get termList => _termList;
  bool get isLoading => _isLoading;

  StakeHolderList _stakeHolderListInActive;
  StakeHolderList get stakeHolderListInActive => _stakeHolderListInActive;

  HomePageViewModel(Map<String, dynamic> map) {
    loadListStakeHolder(map);
  }

  void loadListStakeHolder(Map<String, dynamic> map) async {
    _isLoading = true;
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    sharedPreferences.setString("token", map['token']);
    sharedPreferences.setString("stakeHolderID", map['stakeHolderID']);
    sharedPreferences.setString("stakeHolderName", map['shName']);
    sharedPreferences.setString("companyID", map['companyId']);
    sharedPreferences.setString("role", map['role'].toString());
    sharedPreferences.setString("companyName", map['companyName']);
    sharedPreferences.setString("shImage", map['shImage']);

    _image = map['shImage'];
    _stakeHolderID = map['stakeHolderID'];
    _stakeHolderName = map['shName'];
    _companyName = map['companyName'];

    String token = sharedPreferences.getString("token");
    String companyID = sharedPreferences.getString("companyID");

    //Get StakeHolder inactive list
    _stakeHolderListInActive = await _stakeHolderRepo.stakeHolderInActiveList(token, companyID).whenComplete(() {
      _stakeHolderListInActive = stakeHolderListInActive;
    });

    //Get StakeHolder active list
    _stakeHolderList = await _stakeHolderRepo.stakeHolderList(token, companyID).whenComplete(() {
      _stakeHolderList = stakeHolderList;
      _isLoading = false;
      notifyListeners();
    });
  }

  double getTotalSlice() {
    double total = 0;
    for (int i = 0; i < _stakeHolderList.stakeholderList.length; i++){
      total += _stakeHolderList.stakeholderList[i].sliceAssets;
    }
    return total;
  }


  void loadListStakeHolderAfterChange () async {
    _isLoading = true;
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String token = sharedPreferences.getString("token");
    String companyID = sharedPreferences.getString("companyID");

    //Get StakeHolder inactive list
    _stakeHolderListInActive = await _stakeHolderRepo.stakeHolderInActiveList(token, companyID).whenComplete(() {
      _stakeHolderListInActive = stakeHolderListInActive;
    });

    //Get StakeHolder active list
    _stakeHolderList = await _stakeHolderRepo.stakeHolderList(token, companyID).whenComplete(() {
      _stakeHolderList = stakeHolderList;

      _isLoading = false;
      notifyListeners();
    });
  }


}