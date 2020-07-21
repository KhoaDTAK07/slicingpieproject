class UserDetail {
  String token,stakeHolderID, stakeHolderName, companyID, companyName, image;
  int role;

  UserDetail({this.token, this.stakeHolderID, this.stakeHolderName, this.companyID, this.role, this.companyName, this.image});

  factory UserDetail.fromJson(Map<String, dynamic> json){
    return UserDetail(
      token: json['token'],
      stakeHolderID: json['stakeHolderID'],
      stakeHolderName: json['shName'],
      companyID: json['companyId'],
      role: json['role'],
      companyName: json['companyName'],
      image: json['shImage'],
    );
  }
}