

import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/model/project_model.dart';
import 'package:slicingpieproject/src/repos/project_repo.dart';

class ProjectListViewModel extends Model {
  ProjectRepo projectRepo = ProjectRepoImp();
  ProjectList list = ProjectList();
  String newProject;


  Future<ProjectList> loadData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String companyID = sharedPreferences.getString("companyID");
    list = await projectRepo.getProjectList(companyID);
    return list;
  }

  void refresh() {
    notifyListeners();
  }

  Future<bool> addNewProject() {
      return projectRepo.addProject(newProject);
  }

  Future<bool> updateProject(String projectID) {
    return projectRepo.updateProject(newProject, projectID);
  }

}