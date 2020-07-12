class TypeAsset {
  final int typeAssetId;
  final String nameAsset, multiplierType;

  TypeAsset({this.typeAssetId, this.nameAsset, this.multiplierType});

  factory TypeAsset.fromJson(Map<String, dynamic> json) {
    return TypeAsset(
      typeAssetId: json['typeAssetId'],
      nameAsset: json['nameAsset'],
      multiplierType: json['multiplierType'],
    );
  }
}

class TypeAssetList {
  List<TypeAsset> typeAssetList;

  TypeAssetList({this.typeAssetList});

  factory TypeAssetList.fromJson(List<dynamic> parsedJson) {
    List<TypeAsset> list = new List<TypeAsset>();

    list = parsedJson.map((i) => TypeAsset.fromJson(i)).toList();

    return new TypeAssetList(
      typeAssetList: list,
    );
  }

}