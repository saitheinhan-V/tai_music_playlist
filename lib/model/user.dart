class User{
  late int userId;
  late String name;
  late String phoneNumber;
  late String password;

  User(this.userId, this.name, this.phoneNumber, this.password);

  User.fromJson(Map<String, dynamic> json)
      : userId = json['id'] as int,
        name = json['name'] as String,
        phoneNumber = json['phoneNumber'] as String,
        password = json['password'] as String;

  User.fromJsonMap(Map<String, dynamic> map)
      : userId = map['id'],
        name = map['name'],
        phoneNumber = map['phoneNumber'],
        password = map['password'];
}