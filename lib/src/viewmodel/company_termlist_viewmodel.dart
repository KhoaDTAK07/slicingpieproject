import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/model/term_model.dart';
import 'package:slicingpieproject/src/repos/term_repo.dart';

class CompanyTermListViewModel extends Model {
  TermRepo _termRepo = TermRepoImp();

  TermList termList;


  //Get List of Term
   Future<TermList> loadTermList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String companyID = sharedPreferences.getString("companyID");
    termList = await _termRepo.getTermList(companyID);
    return termList;
  }

  Future<bool> createNewTerm() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String companyID = sharedPreferences.getString("companyID");
      return _termRepo.createNewTerm(companyID);
  }

  void refresh() {
     notifyListeners();
  }

}