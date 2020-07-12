import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/model/term_model.dart';
import 'package:slicingpieproject/src/repos/term_repo.dart';

class TermListViewModel extends Model {
  TermRepo _termRepo = TermRepoImp();

  TermList _termList;
  bool _isLoading = false;

  TermList get termList => _termList;
  bool get isLoading => _isLoading;

  String _selectedDateFromFormat = DateFormat('yyyy/MM/dd').format(DateTime.now());
  String _selectedDateToFormat = DateFormat('yyyy/MM/dd').format(DateTime.now());

  String get selectedDateFromFormat => _selectedDateFromFormat;
  String get selectedDateToFormat => _selectedDateToFormat;



  TermListViewModel() {
    loadTermList();
  }

  //Get List of Term
  void loadTermList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String companyID = sharedPreferences.getString("companyID");
    _isLoading = true;
    notifyListeners();

    _termList = await _termRepo.getTermList(companyID).whenComplete(() {
      _termList = termList;
      _isLoading = false;
      notifyListeners();
    });
  }
}