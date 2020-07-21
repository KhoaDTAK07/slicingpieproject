
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

  static String apiAddStakeHolder() {
    String url = "https://slicingpiepj.azurewebsites.net/api/StackHolders/company/";
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
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID + "/type-asset";
    return url;}
  //---------------------------------- API Contribution --------------------------------------------------
  static String apiAddContribution(String companyID, String stakeHolderID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/SliceAsset/company/" + companyID + "/stake-holer/" + stakeHolderID + "/contribution";
    return url;
  }
  static String apiGetContribution(String companyID) {
    String url = 'https://slicingpiepj.azurewebsites.net/api/Companies/$companyID/Contribution';
    return url;
  }

  static String apiContributionDetail() {
    String url = "https://slicingpiepj.azurewebsites.net/api/SliceAsset/";
    return url;
  }

  static String apiUpdateContribution() {
    String url = "https://slicingpiepj.azurewebsites.net/api/SliceAsset/";
    return url;
  }

}