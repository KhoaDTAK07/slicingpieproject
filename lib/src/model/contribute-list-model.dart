class ContributeListModel {
  String assetId, description, timeAsset, project, namePerson, typeAsset;
  double quantity;

  ContributeListModel({
    this.assetId,
    this.description,
    this.timeAsset,
    this.project,
    this.namePerson,
    this.typeAsset,
    this.quantity,
  });

  factory ContributeListModel.fromJson(Map<String, dynamic> json) {
    return ContributeListModel(
      assetId: json['assetId'],
      description: json['description'],
      timeAsset: json['timeAsset'],
      project: json['project'],
      namePerson: json['namePerson'],
      typeAsset: json['typeAsset'],
      quantity: json['quantity'],
    );
  }
}
