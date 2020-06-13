class StakeHolderList {
  final List<StakeHolder> stakeholderList;

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
  final String shName,shJob,shImage,companyID;
  final double sliceAssets;

  StakeHolder({this.shName, this.shJob, this.shImage, this.companyID, this.sliceAssets});

  factory StakeHolder.fromJson(Map<String, dynamic> json){
    return StakeHolder(
      shName: json['shName'],
      shJob: json['shJob'],
      shImage: json['shImage'],
      companyID: json['companyID'],
      sliceAssets: json['sliceAssets']
    );
  }


}