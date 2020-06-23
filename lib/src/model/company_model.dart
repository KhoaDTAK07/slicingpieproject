class Company {
  String name, icon, id;
  int nonMultiplayer, multiplayer;

  Company({
    this.id,
    this.name,
    this.icon,
    this.nonMultiplayer,
    this.multiplayer
  });


  factory Company.fromJson(Map<String, dynamic> json){
    return Company(
        id: json['companyId'],
        name: json['companyName'],
        icon: json['comapnyIcon'],
        nonMultiplayer: json['nonCashMultiplier'],
        multiplayer: json['cashMultiplier']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "CompanyId": id,
        "CompanyName": name,
        "ComapnyIcon": icon,
        "NonCashMultiplier": nonMultiplayer,
        "CashMultiplier": multiplayer
      };

}