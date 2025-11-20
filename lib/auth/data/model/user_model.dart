class UserModel {
  static const String collection = 'users';
  UserModel({this.name, this.email, this.password, this.id});

  UserModel.fromJson(Map<String, Object?> json)
    : this(
        id: json['id']! as String,
        password: json['password']! as String,
        name: json['name']! as String,
        email: json['email']! as String,
      );

  String? name;
  String? email;
  String? password;
  String? id;

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password, 'id': id};
  }
}
