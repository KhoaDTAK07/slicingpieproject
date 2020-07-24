import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/helper/api_string.dart';
import 'package:slicingpieproject/src/model/project_model.dart';
import 'package:http/http.dart' as http;

abstract class ProjectRepo {
  Future<ProjectList> getProjectList(String companyId);
  Future<bool> addProject(String nameProject);
  Future<bool> updateProject(String nameProject, String projectId);
  Future<ProjectList> getProjectInTermList(int termID);
  Future<bool> addProjectInTerm(int termID, String projectID);
}

class ProjectRepoImp implements ProjectRepo {

  Future<ProjectList> getProjectList(String companyId) async {

    String apiGetProjectList = APIString.apiGetProjectListInCompany(companyId);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String tokenUser = sharedPreferences.getString("token");

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.get(apiGetProjectList, headers: header);

    List<dynamic> list = jsonDecode(response.body);

    ProjectList projectList;
    projectList = ProjectList.fromJson(list);

    return projectList;
  }

  @override
  Future<bool> addProject(String nameProject) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String tokenUser = sharedPreferences.getString("token");
    String companyID = sharedPreferences.getString("companyID");
    Project project = Project(projectName: nameProject, companyID: companyID, projectID: "", projectStatus: "");
    String addJson = jsonEncode(project.toJson());
    String apiAddProject = APIString.apiAddProjectInCompany(companyID);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.post(apiAddProject, headers: headers, body: addJson);
    print('---------------------RESPONSE----------------');
    print(response.statusCode);
    bool isAdded;

    if(response.statusCode == 204) {
      isAdded = true;
      return isAdded;
    } else {
      isAdded = false;
      return isAdded;
    }
  }

  @override
  Future<bool> updateProject(String nameProject, String projectID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String tokenUser = sharedPreferences.getString("token");
    String companyID = sharedPreferences.getString("companyID");
    Project project = Project(projectName: nameProject, companyID: companyID, projectID: projectID, projectStatus: "");
    String addJson = jsonEncode(project.toJson());
    String apiAddProject = APIString.apiUpdateProjectInCompany(companyID, projectID);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.put(apiAddProject, headers: headers, body: addJson);
    print('---------------------RESPONSE----------------');
    print(response.statusCode);
    bool isAdded;

    if(response.statusCode == 204) {
      isAdded = true;
      return isAdded;
    } else {
      isAdded = false;
      return isAdded;
    }
  }

  @override
  Future<ProjectList> getProjectInTermList(int termID) async {
    String apiGetProjectList = APIString.apiGetProjectInTerm(termID);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String tokenUser = sharedPreferences.getString("token");

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.get(apiGetProjectList, headers: header);

    List<dynamic> list = jsonDecode(response.body);

    ProjectList projectList;
    projectList = ProjectList.fromJson(list);

    return projectList;
  }

  @override
  Future<bool> addProjectInTerm(int termID, String projectID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String tokenUser = sharedPreferences.getString("token");
    String apiAddProject = APIString.apiAddProjectInTerm(termID, projectID);

    print(apiAddProject);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $tokenUser",
    };

    http.Response response = await http.post(apiAddProject, headers: headers);
    print('---------------------RESPONSE----------------');
    print(response.statusCode);
    bool isAdded;

    if(response.statusCode == 204) {
      isAdded = true;
      return isAdded;
    } else {
      isAdded = false;
      return isAdded;
    }
  }

}