class StakeHolderList {
  List<StakeHolder> stakeholderList;

  StakeHolderList({
    this.stakeholderList,
  });

  factory StakeHolderList.fromJson(List<dynamic> parsedJson){

    List<StakeHolder> stakeholders = new List<StakeHolder>();

    stakeholders = parsedJson.map((i)=>StakeHolder.fromJson(i)).toList();

    return new StakeHolderList(
      stakeholderList: stakeholders,
    );
  }
}

class StakeHolder {
  final String shID, shName,shJob,shImage,companyID, shNameForCompany, shStatus;
  final double sliceAssets;
  final int shMarketSalary, shSalary, shRole;

  StakeHolder({this.shID, this.shName, this.shJob, this.shImage, this.companyID, this.sliceAssets, this.shMarketSalary, this.shSalary, this.shNameForCompany, this.shStatus, this.shRole});

  factory StakeHolder.fromJson(Map<String, dynamic> json){
    return StakeHolder(
      shID: json['shid'],
      shName: json['shName'],
      shJob: json['shJob'],
      shImage: json['shImage'],
      companyID: json['companyID'],
      sliceAssets: json['sliceAssets']
    );
  }


  Map<String, dynamic> toJson() =>
      {
        "AccountId": shID,
        "CompanyId": companyID,
        "ShmarketSalary": shMarketSalary,
        "Shsalary": shSalary,
        "Shjob": shJob,
        "ShnameForCompany": shNameForCompany,
        "Shimage": shImage,
        "Shstatus": shStatus,
        "Shrole": shRole,
      };
}