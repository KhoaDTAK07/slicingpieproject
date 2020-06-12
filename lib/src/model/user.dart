
class User {
  String email,password;
  String returnSecureToken = "true";

  User(
    this.email,
    this.password,
  );

  Map<String, dynamic> toJson() =>
      {
        "email": email,
        "password": password,
        "returnSecureToken": returnSecureToken
      };
}