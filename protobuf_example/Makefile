gen:
	protoc --dart_out=lib/src/generated -Iprotos protos/google/type/money.proto
	protoc --dart_out=lib/src/generated -Iprotos protos/user.proto protos/transaction.proto

run:
	dart run bin/protobuf_example.dart
