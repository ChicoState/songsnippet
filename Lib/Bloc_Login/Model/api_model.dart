class UserLogin {
  String username;
  String password;

  UserLogin({required this.username, required this.password});

  Map <String, dynamic> toDatabaseJson() => {
    "username": username,
    "password": password
  };
}

class Token{
  String token;

  Token({required this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['token']
    );
  }
}
class UserDetails {
  String username;
  String email;
  String password;

  UserDetails(
      {required this.username,
        required this.email,
        required this.password});

  Map<String, dynamic> toDatabaseJson() => {
    "username": username,
    "email": email,
    "password": password
  };
}
class UserSignup {
  UserDetails user;

  UserSignup({required this.user});

  Map<String, dynamic> toDatabaseJson() => {
    // "user": user.toDatabaseJson(),
    // "profile_type": "user"
    "username": user.username,
    "password": user.password,
    "email": user.email,
  };
}