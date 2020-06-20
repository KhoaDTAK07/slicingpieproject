
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/model/company_model.dart';
import 'package:slicingpieproject/src/repos/company_detail_repo.dart';

class CompanySettingViewModel extends Model {
  CompanyRepo companyRepo = CompanyRepoImp();
  Company company;

  CompanySettingViewModel(String companyID, String tokenUser){
    loadCompanyDetail(companyID, tokenUser);
  }

  void loadCompanyDetail(String companyID, String tokenUser) async {
    company = await companyRepo.companyDetail(companyID, tokenUser);
    notifyListeners();
  }
}