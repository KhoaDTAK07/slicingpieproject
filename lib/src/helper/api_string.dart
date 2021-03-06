
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

  static String apiGetListStakeHolderInActive(String companyID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID + "/stake-holder-inactive";
    return url;
  }

  static String apiAddStakeHolder() {
    String url = "https://slicingpiepj.azurewebsites.net/api/StackHolders/company/";
    return url;
  }

  static String apiGetStakeHolderDetail() {
    String url = "https://slicingpiepj.azurewebsites.net/api/StackHolders/";
    return url;
  }

  static String apiUpdateStakeHolder() {
    String url = "https://slicingpiepj.azurewebsites.net/api/StackHolders/";
    return url;
  }

  static String apiDeleteStakeHolder(String companyID, String accountID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/StackHolders/$companyID/$accountID";
    return url;
  }
  //------------------------------------------------------------------------------------------------------

  //---------------------------------- API Company -------------------------------------------------------
  static String apiGetOverView(String companyID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/$companyID/over-view";
    return url;
  }

  static String apiCompanySetting(String companyID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID;
    return url;
  }
  static String apiGetProjectListInCompany(String companyID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID + "/project";
    return url;
  }

  static String apiAddProjectInCompany(String companyID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID + "/project";
    return url;
  }


  static String apiGetListCompany(String companyID, String accountID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/StackHolders/list-company/$companyID/$accountID";
    return url;
  }

  static String apiSwitchCompany(String companyID, String accountID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Login/switch-account/$accountID/$companyID";
    return url;
  }
  static String apiUpdateProjectInCompany(String companyID, String projectID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID + "/project/" + projectID;
    return url;
  }
  static String apiCreateTermInCompany(String companyID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/" + companyID + "/create-term";
    return url;
  }

  static String apiGetProjectInTerm(int termID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/term/" + termID.toString() + "/project";
    return url;
  }
  static String apiAddProjectInTerm(int termID, String projectID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/term/" + termID.toString() + "/project/" + projectID;
    return url;
  }
  static String apiEndTerm(int termID) {
    String url = "https://slicingpiepj.azurewebsites.net/api/Companies/term-done/" + termID.toString();
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
  static String apiGetContribution(String companyID, int termID) {
    String url = 'https://slicingpiepj.azurewebsites.net/api/Companies/$companyID/term/$termID/contribution';
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