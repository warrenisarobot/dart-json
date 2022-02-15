import 'dart:convert' as convert;
import 'dart:io' as io;

import 'package:built_value_example/serializers.dart';
import 'package:built_value_example/user.dart';

void consumeJson(String jsonBody) {
  //it is requried that we convert to a json map first, then the
  var result = convert.jsonDecode(jsonBody);
  //the value of `u` can potentially be `null` here
  var u = serializers.deserializeWith(User.serializer, result);
  print("User instance from JSON: $u");
}

void produceJson() {
  //jsonEncode takes any Map<String, dynamic> and produces a JSON encoded string
  var u = User((b) => b
    ..firstname = "bob"
    ..lastname = "loblaw"
    ..username = "lawman"
    ..email = "bobloblaw@lawman.com"
    ..age = 33);

  var serialzeMe = serializers.serializeWith(User.serializer, u);
  var jsonStringBody = convert.jsonEncode(serialzeMe);
  print("Encoded JSON body: $jsonStringBody");
}

void main(List<String> arguments) {
  var f = io.File('../data/consume.json');
  var jsonBody = f.readAsStringSync();
  consumeJson(jsonBody);
  produceJson();
}
