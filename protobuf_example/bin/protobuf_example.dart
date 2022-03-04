import 'dart:convert';
import 'dart:ffi';

import 'package:protobuf_example/src/generated/google/type/money.pb.dart';
import 'package:protobuf_example/src/generated/user.pb.dart';
import 'package:protobuf_example/src/generated/transaction.pb.dart';
import 'package:fixnum/fixnum.dart' as $fixnum;

void main(List<String> arguments) {
  print("############ User #############################");
  userExample();
  print("############ Transaction ######################");
  transactionExample();
}

void userExample() {
  // instantiation
  final User user = User.create()
    ..firstName = "bob"
    ..lastName = "loblaw"
    ..username = "lawman"
    ..email = "bobloblaw@lawman.com"
    ..age = 33;
  print('Original:\n$user');

  // can optionally make the object immutable
  // Unsupported operation: Attempted to change a read-only message (previ.User)
  user.freeze();

  // serialization
  var json = jsonEncode(user.toProto3Json());
  print('Serialized JSON: $json\n');

  // deserialization
  var deserializedUser = User.create()..mergeFromProto3Json(jsonDecode(json));
  print('Deserialized:\n$deserializedUser');
}

void transactionExample() {
  // instantiation
  final Money amount = Money.create()
    ..currencyCode = "USD"
    ..units = $fixnum.Int64.parseInt("1")
    ..nanos = 750000000;

  final Transaction transaction = Transaction.create()
    ..category = "shopping"
    ..amount = amount;
  print('Original:\n$transaction');

  // serialization
  var json = jsonEncode(transaction.toProto3Json());
  print('Serialized JSON: $json\n');

  // deserialization
  var desTrans = Transaction.create()..mergeFromProto3Json(jsonDecode(json));
  print('Deserialized:\n$desTrans');
}
