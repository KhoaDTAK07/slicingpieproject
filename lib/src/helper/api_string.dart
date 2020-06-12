
class APIString {

  static String apiLogin() {
    String url = "https://slicingpieproject.azurewebsites.net/api/login";
    return url;
  }

  static String apiGetListStakeHolder() {
    String url = "https://slicingpieproject.azurewebsites.net/api/Companies/[CompanyID]/stake-holder";
    return url;
  }

  static String apiCheckFirebaseNormalLogin() {
    String url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAK2LGTJBlGvLvPAH9vz0XRGZOL71O0oQk";
    return url;
  }

}