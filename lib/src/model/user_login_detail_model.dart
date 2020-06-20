class UserDetail {
  String token,stakeHolderID, companyID;
  int role;

  UserDetail({this.token, this.stakeHolderID, this.companyID, this.role});

  factory UserDetail.fromJson(Map<String, dynamic> json){
    return UserDetail(
      token: json['token'],
      stakeHolderID: json['stakeHolderID'],
      companyID: json['companyId'],
      role: json['role']
    );
  }
}