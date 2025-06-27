class UserModel {
  final String name;
  final String email;

  UserModel({required this.name, required this.email});

  Map<String, dynamic> toMap() => {'name': name, 'email': email};

  factory UserModel.fromMap(Map<String, dynamic> map) =>
      UserModel(name: map['name'], email: map['email']);
}
