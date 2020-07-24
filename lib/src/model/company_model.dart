class Company {
  String name, icon, id;
  int nonMultiplayer, multiplayer;
  double cashPerSlice;

  Company({
    this.id,
    this.name,
    this.icon,
    this.nonMultiplayer,
    this.multiplayer,
    this.cashPerSlice,
  });


  factory Company.fromJson(Map<String, dynamic> json){
    return Company(
        id: json['companyId'],
        name: json['companyName'],
        icon: json['comapnyIcon'],
        nonMultiplayer: json['nonCashMultiplier'],
        multiplayer: json['cashMultiplier'],
        cashPerSlice: json['cashPerSlice']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "CompanyId": id,
        "CompanyName": name,
        "ComapnyIcon": icon,
        "NonCashMultiplier": nonMultiplayer,
        "CashMultiplier": multiplayer,
        "CashPerSlice": cashPerSlice,
      };

}

class CompanyList {
  List<Company> companyList;

  CompanyList({
    this.companyList,
  });

  factory CompanyList.fromJson(List<dynamic> parsedJson){

    List<Company> companies = new List<Company>();

    companies = parsedJson.map((i) => Company.fromJson(i)).toList();

    return new CompanyList(
      companyList: companies,
    );
  }
}