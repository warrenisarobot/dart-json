///
//  Generated code. Do not modify.
//  source: helloworld.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use helloRequestDescriptor instead')
const HelloRequest$json = const {
  '1': 'HelloRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'justAnotherTest', '3': 2, '4': 1, '5': 9, '10': 'justAnotherTest'},
  ],
};

/// Descriptor for `HelloRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloRequestDescriptor = $convert.base64Decode('CgxIZWxsb1JlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRIoCg9qdXN0QW5vdGhlclRlc3QYAiABKAlSD2p1c3RBbm90aGVyVGVzdA==');
@$core.Deprecated('Use helloReplyDescriptor instead')
const HelloReply$json = const {
  '1': 'HelloReply',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `HelloReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloReplyDescriptor = $convert.base64Decode('CgpIZWxsb1JlcGx5EhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
const $core.Map<$core.String, $core.dynamic> GreeterServiceBase$json = const {
  '1': 'Greeter',
  '2': const [
    const {'1': 'SayHello', '2': '.helloworld.HelloRequest', '3': '.helloworld.HelloReply', '4': const {}},
    const {'1': 'SayHelloAgain', '2': '.helloworld.HelloRequest', '3': '.helloworld.HelloReply', '4': const {}},
  ],
};

@$core.Deprecated('Use greeterServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> GreeterServiceBase$messageJson = const {
  '.helloworld.HelloRequest': HelloRequest$json,
  '.helloworld.HelloReply': HelloReply$json,
};

/// Descriptor for `Greeter`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List greeterServiceDescriptor = $convert.base64Decode('CgdHcmVldGVyEj4KCFNheUhlbGxvEhguaGVsbG93b3JsZC5IZWxsb1JlcXVlc3QaFi5oZWxsb3dvcmxkLkhlbGxvUmVwbHkiABJDCg1TYXlIZWxsb0FnYWluEhguaGVsbG93b3JsZC5IZWxsb1JlcXVlc3QaFi5oZWxsb3dvcmxkLkhlbGxvUmVwbHkiAA==');
