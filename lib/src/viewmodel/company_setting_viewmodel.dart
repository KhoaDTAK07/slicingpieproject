
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/model/company_model.dart';
import 'package:slicingpieproject/src/repos/company_detail_repo.dart';

class CompanySettingViewModel extends Model {
  CompanyRepo companyRepo = CompanyRepoImp();
  Company _company;
  Company get company => _company;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CompanySettingViewModel(String companyID, String tokenUser){
    loadCompanyDetail(companyID, tokenUser);
  }

  void loadCompanyDetail(String companyID, String tokenUser) async {
    _isLoading = true;
    notifyListeners();
    _company = await companyRepo.companyDetail(companyID, tokenUser).whenComplete(() {
      _company = company;
      _isLoading = false;
      notifyListeners();
    });
  }
}