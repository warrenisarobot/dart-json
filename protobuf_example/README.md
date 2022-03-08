# JSON serialization/deserialization using Protobuf

A simple command-line application to demonstrate JSON searialization/deserialization using Protobuf.

Output of example code:

```
% make run
dart run bin/protobuf_example.dart
############ User #############################
Original:
firstName: bob
lastName: loblaw
username: lawman
email: bobloblaw@lawman.com
age: 33

Serialized JSON: {"firstName":"bob","lastName":"loblaw","username":"lawman","email":"bobloblaw@lawman.com","age":33}

Deserialized:
firstName: bob
lastName: loblaw
username: lawman
email: bobloblaw@lawman.com
age: 33

############ Transaction ######################
Original:
category: shopping
amount: {
  currencyCode: USD
  units: 1
  nanos: 750000000
}

Serialized JSON: {"category":"shopping","amount":{"currencyCode":"USD","units":"1","nanos":750000000}}

Deserialized:
category: shopping
amount: {
  currencyCode: USD
  units: 1
  nanos: 750000000
}
```