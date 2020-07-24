import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/model/company_model.dart';
import 'package:slicingpieproject/src/repos/company_switch_repo.dart';

class CompanySwitchViewModel extends Model {
  CompanySwitchRepo _companySwitchRepo = CompanySwitchRepoImp();
  CompanyList _companyList;
  CompanyList get companyList => _companyList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CompanySwitchViewModel() {
    loadCompanyList();
  }

  void loadCompanyList() async {
    _isLoading = true;
    notifyListeners();

    _companyList = await _companySwitchRepo.getListCompany().whenComplete(() {
      _companyList = companyList;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<dynamic> switchCompany(String companyID) {
    return _companySwitchRepo.switchCompany(companyID);
  }
}