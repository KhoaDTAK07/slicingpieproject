import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/model/stakeholder_model.dart';
import 'package:slicingpieproject/src/model/user_login_detail_model.dart';
import 'package:slicingpieproject/src/repos/stakeholder_repo.dart';
import 'package:slicingpieproject/src/repos/user_login_detail_repo.dart';

class HomePageViewModel extends Model {
  UserDetailRepo userDetailRepo = UserDetailRepoImp();
  StakeHolderRepo stakeHolderRepo = StakeHolderRepoImp();
  final formatter = new NumberFormat("(##,##%)");
  String userToken;

  Future<UserDetail> getUserDetail(String tokenLogIn) async {
    UserDetail userDetail = await userDetailRepo.fetchUserLoginDetail(tokenLogIn);
    return userDetail;
  }

  StakeHolderList _stakeHolderList;
  bool _isLoading = false;

  StakeHolderList get stakeHolderList => _stakeHolderList;
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

  Future<String> getUserToken (String tokenLogIn) async {
    String userToken;
    UserDetail userDetail = await getUserDetail(tokenLogIn);
    userToken = userDetail.token;
    return userToken;
  }


  void loadListStakeHolderByNormalSignIn (String tokenLogIn) async {
    _isLoading = true;
    notifyListeners();
    UserDetail userDetail = await getUserDetail(tokenLogIn);
    _stakeHolderList = await stakeHolderRepo.stakeHolderList(userDetail.token, userDetail.companyID).whenComplete(() {
      _stakeHolderList = stakeHolderList;
      _isLoading = false;
      userToken = userDetail.token;
      notifyListeners();
    });
  }

  void loadListStakeHolderByGoogleSignIn (String userToken, String companyID) async {
    _stakeHolderList = await stakeHolderRepo.stakeHolderList(userToken, companyID);
    notifyListeners();
  }

}