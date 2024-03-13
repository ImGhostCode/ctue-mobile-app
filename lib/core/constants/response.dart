import 'package:dio/dio.dart';

class ResponseDataModel<D> {
  final D data;
  final int statusCode;
  final String message;

  ResponseDataModel({
    required this.data,
    required this.statusCode,
    required this.message,
  });

  factory ResponseDataModel.fromJson({
    required dynamic json,
    required D Function(dynamic) fromJsonD,
  }) {
    if (json.runtimeType == Response<dynamic>) {
      return ResponseDataModel(
        data: fromJsonD(json.data),
        message: json.statusMessage,
        statusCode: json.statusCode,
      );
    }
    return ResponseDataModel(
      data: fromJsonD(json['data'] ?? json.data),
      message: json?['message'] ?? json.statusMessage,
      statusCode: json?['statusCode'] ?? json.statusCode,
    );
  }

  Map<String, dynamic> toJson({
    required Map<String, dynamic> Function(D) toJsonD,
  }) {
    return {
      'data': toJsonD(data),
      'message': message,
      'statusCode': statusCode,
    };
  }
}
