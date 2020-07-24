import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slicingpieproject/src/model/project_model.dart';
import 'package:slicingpieproject/src/repos/project_repo.dart';
import 'package:slicingpieproject/src/repos/term_repo.dart';

class ProjectListInTermViewModel extends Model {
  ProjectRepo projectRepo = ProjectRepoImp();
  TermRepo termRepo = TermRepoImp();
  ProjectList list = ProjectList();
  String project;
  String _idProject;
  List<String> projectName = List<String>();
  ProjectList listAll = ProjectList();

  Future<ProjectList> loadData(int termID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String companyID = sharedPreferences.getString("companyID");
     listAll = await projectRepo.getProjectList(companyID);

    for (int i = 0; i < listAll.projectList.length; i++) {
      projectName.add(listAll.projectList[i].projectName);
    }

    list = await projectRepo.getProjectInTermList(termID);
    return list;
  }

  void changeSelectedProject(String newValue) {
    project = newValue;
    _idProject = listAll.projectList[projectName.indexOf(newValue)].projectID;
    print(_idProject);
  }

  void refresh() {
    notifyListeners();
  }

  Future<bool> addProject(int termID) {
    return projectRepo.addProjectInTerm(termID, _idProject);
  }

  Future<bool> endTerm(int termID) {
      return termRepo.endTerm(termID);
  }
}