
class APIString {

  //---------------------------------- API Login ---------------------------------------------------
  static String apiLogin() {
    String url = "https://slicingpiepj.azurewebsites.net/api/login";
    return url;
  }

  static String apiCheckFirebaseNormalLogin() {
    String url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAK2LGTJBlGvLvPAH9vz0XRGZOL71O0oQk";
    return url;
  }
  //------------------------------------------------------------------------------------------------------

  //---------------------------------- API StakeHolder ---------------------------------------------------
  static String apiGetListStakeHolder(String companyID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID + "/stake-holder";
    return url;
  }
  //------------------------------------------------------------------------------------------------------

  //---------------------------------- API Company -------------------------------------------------------
  static String apiCompanySetting(String companyID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID;
    return url;
  }
  //------------------------------------------------------------------------------------------------------

  //---------------------------------- API Projects -------------------------------------------------------
  static String apiGetProjectList(String companyID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID + "/project";
    return url;
  }

  static String apiPostProject(String companyID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID + "/project";
    return url;
  }

  static String apiPutProject(String companyID, String projectID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID + "/project" + projectID;
    return url;
  }

  static String apiDeleteProject(String companyID, String projectID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID + "/project" + projectID;
    return url;
  }
  //------------------------------------------------------------------------------------------------------

  //---------------------------------- API Contribution --------------------------------------------------
  static String apiAddContribution(String companyID, String stakeHolderID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID + "/StakeHoler/" + stakeHolderID + "/Contribution";
    return url;
  }
  static String apiGetContribution(String companyID) {
    String url = 'https://slicingpiepj.azurewebsites.net/api/Companies/$companyID/Contribution';
    return url;
  }

}