import 'dart:convert';

import 'package:protobuf_example/src/generated/helloworld.pb.dart';

import 'package:protobuf/protobuf.dart';

void main(List<String> arguments) {
  // create the object using builder pattern
  final HelloRequest helloRequest = HelloRequest.create()
    ..firstName = 'John'
    ..lastName = 'Smith';

  // serialize
  var json = jsonEncode(helloRequest.toProto3Json());
  print(json);

  // deserialize
  var request = HelloRequest.create()..mergeFromProto3Json(jsonDecode(json));
  print("First name: ${request.firstName}");
  print("Last name: ${request.lastName}");
}
