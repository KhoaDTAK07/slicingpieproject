import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/model/stakeholder_model.dart';
import 'package:slicingpieproject/src/model/term_model.dart';
import 'package:slicingpieproject/src/model/user_login_detail_model.dart';
import 'package:slicingpieproject/src/repos/stakeholder_repo.dart';
import 'package:slicingpieproject/src/repos/term_repo.dart';
import 'package:slicingpieproject/src/repos/user_login_detail_repo.dart';

class HomePageViewModel extends Model {
  UserDetailRepo userDetailRepo = UserDetailRepoImp();
  StakeHolderRepo stakeHolderRepo = StakeHolderRepoImp();
  TermRepo _termRepo = TermRepoImp();
  final formatter = new NumberFormat("(##,##%)");

  StakeHolderList _stakeHolderList;
  TermList _termList;
  bool _isLoading = false;

  StakeHolderList get stakeHolderList => _stakeHolderList;
  TermList get termList => _termList;
  bool get isLoading => _isLoading;



  HomePageViewModel(String tokenLogIn, int num, String companyID) {
    if(num == 1){
      print("1");
      print("token: " + tokenLogIn);
      loadListStakeHolderByNormalSignIn(tokenLogIn);
    }else{
      print("2");
      print("token: " + tokenLogIn);
      print("company: " + companyID);
      loadListStakeHolderByGoogleSignIn(tokenLogIn, companyID);
    }
  }


  double getTotalSlice() {
    double total = 0;
    for (int i = 0; i < _stakeHolderList.stakeholderList.length; i++){
      total += _stakeHolderList.stakeholderList[i].sliceAssets;
    }
    return total;
  }

  String getFormat(double num) {
    String result;
    result = formatter.format(num);
    return result;
  }


  void loadListStakeHolderByNormalSignIn (String tokenLogIn) async {
    _isLoading = true;
    notifyListeners();

    UserDetail userDetail = await userDetailRepo.fetchUserLoginDetail(tokenLogIn);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("tokenLogIn", tokenLogIn);
    sharedPreferences.setString("token", userDetail.token);
    sharedPreferences.setString("stakeHolderID", userDetail.stakeHolderID);
    sharedPreferences.setString("companyID", userDetail.companyID);
    sharedPreferences.setString("role", userDetail.role.toString());

    String token = sharedPreferences.getString("token");
    String companyID = sharedPreferences.getString("companyID");

    _stakeHolderList = await stakeHolderRepo.stakeHolderList(token, companyID).whenComplete(() {
      _stakeHolderList = stakeHolderList;
      _isLoading = false;
      notifyListeners();
    });
  }

  void loadListStakeHolderByGoogleSignIn (String userToken, String companyID) async {
    _stakeHolderList = await stakeHolderRepo.stakeHolderList(userToken, companyID);
    notifyListeners();
  }

}