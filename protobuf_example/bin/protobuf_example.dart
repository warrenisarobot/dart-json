import 'dart:convert';

import 'package:protobuf_example/src/generated/user.pb.dart';

import 'package:protobuf/protobuf.dart';

void main(List<String> arguments) {
  // instantiation
  final User user = User.create()
    ..firstName = "bob"
    ..lastName = "loblaw"
    ..username = "lawman"
    ..email = "bobloblaw@lawman.com"
    ..age = 33;

  // can optionally make the object immutable, if you try to modify the object, you get: Unsupported operation: Attempted to change a read-only message (previ.User)
  user.freeze();

  // serialize
  var json = jsonEncode(user.toProto3Json());
  print('Serialized JSON: $json\n');

  // deserialize
  var deserializedUser = User.create()..mergeFromProto3Json(jsonDecode(json));
  print('Deserialized:\n$deserializedUser');
}
