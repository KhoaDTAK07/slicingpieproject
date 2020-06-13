class Company {
  String name,icon;
  int nonMultiplayer, multiplayer;

  Company({
      this.name,
      this.icon,
      this.nonMultiplayer,
      this.multiplayer
  });


  factory Company.fromJson(Map<String, dynamic> json){
    return Company(
        name: json['companyName'],
        icon: json['comapnyIcon'],
        nonMultiplayer: json['nonCashMultiplier'],
        multiplayer: json['cashMultiplier']
    );
  }

}