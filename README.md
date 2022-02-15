# Using JSON in Dart

This repo includes demos for 3 types of serailization.  These can be tested by entering the folder, and doing a `dart run`.

## Overview

All JSON serialization methods in dart use the [convert](https://dart.dev/guides/libraries/library-tour#dartconvert---decoding-and-encoding-json-utf-8-and-more) package, and extend its functionality to include better support for static types.

The convert library Takes deserialized JSON into a `Map<String, dynamic>` when reading JSON, and deserializes the same `Map<string, dynamic>` into a string when writing JSON.  

This allows reading JSON like this:

```
import 'dart:convert';

var jsonBody = '''
{
    "firstname":"bob",
    "lastname": "loblaw",
    "username": "lawman",
    "email": "bobloblaw@lawman.com",
    "age": 33
}
''';

void main() {
  var res = jsonDecode(jsonBody);
  print(res["firstname"]);
  //bob
  print(res["age"]);
  //33
  print(res["favoriteColor"]);
  //null
}

```

This is great for prototyping, but does not use any static types.  Dart JSON solutions that serialize/deserialize JSON to a dart static type follow the pattern of:
* Use the `convert` package to deserialize JSON
* Construct a dart class that takes a JSON `Map<String, dynamic>` as its parameter
* The constructor assigns the Instance's property to the correponding JSON map's key value, if it exists

An example of this pattern is on the [flutter site](https://docs.flutter.dev/development/data-and-backend/json#serializing-json-inside-model-classes).  When we are the producer of JSON and we already have a class witht the properties we want this adds boilerplate and can be repetitive.  There are code generation solutions for this as well.


## Code Generation

There are 2 common packages for dart to provide the boilerplate code for turning dart JSON maps from the `convert` package into a static dart type.  Both use code generation from a package called [build_runner](https://pub.dev/packages/build_runner) that is designed to give a common way for dart programs to generate dart code.  These are:

* [json_serializable](https://pub.dev/packages/json_serializable)
* [built_value](https://pub.dev/packages/built_value)

Both require boilerplate template code to be added (this can be done via snippets with our editors), then the code generation to be run.  Code geenration is done the same with all dart package with a command like `dart run build_runner build`.

It does seem to be required to put dart code that requires code generation in the `/lib` folder.

### json_serializable

There is an example serialization project using json_serialiazble in the `json_serializable_example` folder.

The bulk of the work with [JSON Serializable](https://pub.dev/packages/json_serializable) is done via annotations.  If a class has a `@JsonSerializable()` annotation, and has the correct boilerplate class methods then code generation will be able to generate the correct code.  This is what the mi nimum code looks like (fromt he json_serializable_example folder:

```
@JsonSerializable()
class User {
  //Below is the required boilerplate for the generated code to connect to
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

```

In this case the name of the class is `User` and would be replaced with the desired class name instead.  The Factory name, and tokens must include the class name like `_$UserFromJson` and `$_UserToJson`.  This provides a `User.fromJson` factory to create a `User` from a JSON Map aquired from a `jsonDecode()`, and provides a `User.toJson` method to create a JSON Map from the User instance.  In both cases you still do use `jsonDecode()` and `jsonEncode()`.

The JSON key name, nullability and other options are configured with annotations on the property using [JsonKey](https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonKey-class.html).

When using code generation it is required to specify what the generated code's filename will with with the `part` directive.  Convention is that the same filename is used, ending in `g.dart` instead of `.dart.`.  The above file is named `user.dart`, and the file would include this line to also include the genrated dart code:

`part 'user.g.dart';`

JsonSeriazable uses normal dart classes.  Any additional methods can be added to the class to get other behavior.

Creating an instance of the class is the same as any class constructor, like:

```
var u = User("bob", "jones", "bobbyj", "bobjones@aol.com", "50");
```


### built_value

There is an example serialization project using built_value in the `built_value_example` folder.

[built_value](https://pub.dev/packages/built_value) is a package that creates objects using the [Builder Pattern](https://en.wikipedia.org/wiki/Builder_pattern).  This creates objects that are immutable, and comparable by _value_.  When an object is created using the builder it cannot be changed after creation.  When 2 separate instances of a built object/built value are compared they will return true if the values match.  Equivalence is overloaded with these so that it is not checking to see if it is the same instance, but that the nested values match.  Built values also provide object serialization in different formats, but these still do put them into JSON Maps for the `convert` package to encode.

built_value doesn't require annotation for code geneation, but can use annotation on properties to do validation or other serialization configuration.  The code generation boilerplate for built values is required in 2 files.  The first is for the class itself, which is defined as an _abstract_ class.  The second is a definition for a global serializer which will register this defined class as available for serialization.

Boilerplate for the class:

```
abstract class User implements Built<User, UserBuilder> {
  //Below is the required boilerplate for the generated code to connect to
  User._();
  factory User([void Function(UserBuilder) updates]) = _$User;
  static Serializer<User> get serializer => _$userSerializer;
}

```

Boilerplate for the serializer registering the class:

```
@SerializersFor([User])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
```

This global serializer is using the `StandardJsonPlugin` which will encode and decode JSON like:

```
{
  "name": "bob,
  "color: "red"
}
```

The default serializer uses an array, like this:


```
["name", "bob", "color", "red"]
```


This first can be done with code editor snippets automatically.  The serializer registration would be more of a manual process.

Constructing a Built Value is done using a factory that you provide a function that operates on a builder instance to setup the initial values and gets an instance back.  This is often done with the `..` [cascade notation](https://dart.dev/guides/language/language-tour#cascade-notation), like this:

```
  var u = User((b) => b
    ..firstname = "bob"
    ..lastname = "jones"
    ..username = "bobbyj"
    ..email = "bobjones@aol.com",
    ..age = 33);

```

The `u` User instance after this has properties for firstname, lastname, etc, but they cannot be modified.  Only `get` accessors are provided.  If the object needs to be changed a new, updated, copy can be made with the `rebuild()` method to replace only the fields we want replaced.  The objects can be compared directly based on values for equivalence.

Serialization is done with the global serializer.  The default serializer includes a "discriminator" which defines the class name.  JSON serialization in API calls do not include this information so when we serialize and deserialize we include the class doing the serialization with the methods `serializeWith` and `deserializeWith()`.  Using the serializer looks like this:

```
//jsonBody contains the JSON string we want to parse
var jsonMap = jsonDecode(jsonBody);
var user = serializers.deserializeWith(User.serializer, jsonMap);


//to serialze back to a JSON string we first make the json map, then encode to string with an already made user object
jsonMap = serializers.serializeWith(User.serializer, user);
jsonBody = jsonEncode(jsonMap);
```
