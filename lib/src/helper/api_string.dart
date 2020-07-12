
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
  //---------------------------------- API Term --------------------------------------------------
  static String apiGetListTerm(String companyID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID + "/list-term";
    return url;
  }
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
  static String apiGetProjectListInTerm(String termID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/term/" + termID + "/project";
    return url;
  }

  //------------------------------------------------------------------------------------------------------
  //---------------------------------- API Assets --------------------------------------------------
  static String apiGetListAssetInCompany(String companyID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID + "/TypeAsset";
    return url;}
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