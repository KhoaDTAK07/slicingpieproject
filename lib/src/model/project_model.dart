class Project {
  final String projectID, projectName, projectStatus, companyID;

  Project({this.projectID, this.projectName, this.projectStatus, this.companyID});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectID: json['projectId'],
      projectName: json['projectName'],
      projectStatus: json['projectStatus'],
      companyID: json['companyId'],
    );
  }


  Map<String, dynamic> toJson() =>
  {
  "ProjectId": projectID,
  "ProjectName": projectName,
  "ProjectStatus": projectStatus,
    "CompanyId" : companyID,
  };


}

class ProjectList {
  List<Project> projectList;

  ProjectList({this.projectList});

  factory ProjectList.fromJson(List<dynamic> parsedJson) {
    List<Project> projects = new List<Project>();
    
    projects = parsedJson.map((i) => Project.fromJson(i)).toList();

    return new ProjectList(
      projectList: projects,
    );
  }

}

