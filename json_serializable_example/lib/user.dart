import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String firstname;
  String lastname;
  String username;
  String email;
  int age;
  User(this.firstname, this.lastname, this.username, this.email, this.age);

  //Below is the required boilerplate for the generated code to connect to
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
