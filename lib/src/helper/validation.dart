class Validation {
  static String validatePass(String pass) {
    if (pass == null) {
      return "Password can't be blank";
    }else if(pass.length < 6) {
      return "Password require minimum 6 characters";
    }else
      return null;
  }

  static String validateEmail(String email) {
    var isValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (email == null) {
      return "Email can't be blank";
    }else if(!isValid) {
      return "Email invalid.";
    }else
      return null;
  }

  static String validateCompanyName(String name) {
    if (name == null){
      return "Company name can't be blank";
    }

    return null;
  }

  static String validateNonCashMul(int nonCash) {
    if (nonCash == 0){
      return "Non-Cash value must greater than zero";
    }

    return null;
  }

  static String validateCashMul(int cash) {
    if (cash == 0){
      return "Cash value must greater than zero";
    }

    return null;
  }

}