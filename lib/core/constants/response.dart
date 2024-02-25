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
    required Map<String, dynamic> json,
    required D Function(dynamic) fromJsonD,
  }) {
    return ResponseDataModel(
      data: fromJsonD(json['data']),
      message: json['message'],
      statusCode: json['statusCode'],
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
