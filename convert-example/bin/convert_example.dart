import 'dart:convert' as convert;
import 'dart:io' as io;

void consumeJson(String jsonBody) {
  // jsonDecode returns a Map<String, dynamic> with the key as the JSON key, and the value is the corresopnding JSON type (string, int, list, map).
  // All methods of json decoding use the result of this to add the content to properties of a class
  //
  // The value is dynamic so we don't have a class to act as a template for what the data should look like.
  var result = convert.jsonDecode(jsonBody);
  print(
      "Convert JSON parts:\n\tfirstname: ${result['firstname']}\n\tlastname: ${result['lastname']}\n\temail: ${result['email']}\n\tage: ${result['age']}");
}

void produceJson() {
  //jsonEncode takes any Map<String, dynamic> and produces a JSON encoded string
  var userData = {
    "firstname": "bob",
    "lastname": "loblaw",
    "username": "lawman",
    "email": "bobloblaw@lawman.com",
    "age": 33
  };
  var jsonStringBody = convert.jsonEncode(userData);
  print("Encoded JSON body: $jsonStringBody");
}

void main(List<String> arguments) {
  var f = io.File('../data/consume.json');
  var jsonBody = f.readAsStringSync();
  consumeJson(jsonBody);
  produceJson();
}
