class UserModel {
  String? userName;
  String? email;
  String? password;

  UserModel({this.userName, this.email, this.password});

 static UserModel fromJsonToModel(Map<String, dynamic> json) {
    return UserModel(
      userName: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }
}