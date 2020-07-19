class ContributionDetailModel{
  final String assetID, description, timeAsset, projectID, termID, companyID;
  final int multiplierInTime, typeAssetID;
  final double quantity, assetSlice, salaryGapInTime, CashPerSlice;


  ContributionDetailModel(
  {
   this.assetID,
   this.description,
   this.timeAsset,
   this.projectID,
   this.companyID,
   this.quantity,
   this.multiplierInTime,
   this.typeAssetID,
   this.termID,
   this.assetSlice,
   this.salaryGapInTime,
   this.CashPerSlice,
  });

  factory ContributionDetailModel.fromJson(Map<String, dynamic> json){
    return ContributionDetailModel(
        assetID: json['assetId'],
        quantity: json['quantity'],
        description: json['description'],
        timeAsset: json['timeAsset'],
        multiplierInTime: json['multiplierInTime'],
        projectID: json['projectId'],
        typeAssetID: json['typeAssetId'],
        termID: json['termId'],
        assetSlice: json['assetSlice'],
        companyID: json['companyId'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "AssetId": assetID,
        "Quantity": quantity,
        "Description": description,
        "TimeAsset": timeAsset,
        "MultiplierInTime": multiplierInTime,
        "ProjectId": projectID,
        "TypeAssetId": typeAssetID,
        "TermId": termID,
        "AssetSlice": assetSlice,
        "CompanyId": companyID,
        "SalaryGapInTime": 0,
        "CashPerSlice": 0,
      };

}