
class APIString {

  static String apiLogin() {
    String url = "https://slicingpieproject.azurewebsites.net/api/login";
    return url;
  }

  static String apiGetListStakeHolder(String companyID) {
    String url = "https://slicingpieproject.azurewebsites.net/api/Companies/" + companyID + "/stake-holder";
    return url;
  }

  static String apiCheckFirebaseNormalLogin() {
    String url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAK2LGTJBlGvLvPAH9vz0XRGZOL71O0oQk";
    return url;
  }

  static String apiCompanySetting(String companyID) {
    String url = "https://slicingpieproject.azurewebsites.net/api/Companies/" + companyID;
    return url;
  }

}