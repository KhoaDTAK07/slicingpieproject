
class UserLogin {
  String email,password;
  String returnSecureToken = "true";
  String userToken;

  UserLogin(
    this.email,
    this.password,
  );

  Map<String, dynamic> toJson() =>
      {
        "email": email,
        "password": password,
        "returnSecureToken": returnSecureToken
      };

//  factory User.fromJson(Map<String, dynamic> json) {
//    return User (
//
//    );
//  }
}