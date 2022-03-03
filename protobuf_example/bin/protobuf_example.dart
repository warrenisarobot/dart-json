import 'dart:convert';

import 'package:protobuf_example/src/generated/user.pb.dart';

import 'package:protobuf/protobuf.dart';

void main(List<String> arguments) {
  final User user = User.create()
    ..firstName = "bob"
    ..lastName = "loblaw"
    ..username = "lawman"
    ..email = "bobloblaw@lawman.com"
    ..age = 33;
  print('Original:\n$user');

  // serialize
  var json = jsonEncode(user.toProto3Json());
  print('Serialized JSON: $json\n');

  // deserialize
  var deserializedUser = User.create()..mergeFromProto3Json(jsonDecode(json));
  print('Deserialized:\n$deserializedUser');
}
