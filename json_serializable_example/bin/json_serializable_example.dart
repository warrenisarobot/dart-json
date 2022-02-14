import 'dart:convert' as convert;
import 'dart:io' as io;

import 'package:json_serializable_example/user.dart';

void consumeJson(String jsonBody) {
  //it is requried that we convert to a json map first, then the
  var result = convert.jsonDecode(jsonBody);
  var u = User.fromJson(result);
  print("User instance from JSON: $u");
}

void produceJson() {
  //jsonEncode takes any Map<String, dynamic> and produces a JSON encoded string
  var u = User("bob", "loblaw", "lawman", "bobloblaw@lawman.com", 33);
  var result = u.toJson();
  var jsonStringBody = convert.jsonEncode(result);
  print("Encoded JSON body: $jsonStringBody");
}

void main(List<String> arguments) {
  var f = io.File('../data/consume.json');
  var jsonBody = f.readAsStringSync();
  consumeJson(jsonBody);
  produceJson();
}
