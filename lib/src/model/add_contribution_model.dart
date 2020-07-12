class AddContributionModel {
  final String description, accountID, projectID, typeAssetID, companyID, timeAsset;
  final int quantity, termID;

  AddContributionModel({this.quantity, this.description, this.timeAsset, this.accountID, this.projectID, this.typeAssetID, this.termID, this.companyID});

  Map<String, dynamic> toJson() =>
      {
        "AssetId": null,
        "Quantity": quantity,
        "Description": description,
        "TimeAsset": timeAsset,
        "MultiplierInTime": 0,
        "AccountId": accountID,
        "ProjectId": projectID,
        "TypeAssetId": typeAssetID,
        "TermId": termID,
        "AssetStatus": "null",
        "AssetSlice": 0,
        "CompanyId": companyID,
        "SalaryGapInTime": 0,
        "CashPerSlice": 0
      };
}