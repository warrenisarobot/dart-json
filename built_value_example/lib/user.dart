import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  String get firstname;
  String get lastname;
  String get username;
  String get email;
  int get age;

  //Below is the required boilerplate for the generated code to connect to
  User._();
  factory User([void Function(UserBuilder) updates]) = _$User;
  static Serializer<User> get serializer => _$userSerializer;
}
