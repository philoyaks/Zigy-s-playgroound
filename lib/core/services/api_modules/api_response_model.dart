class ResponseModel<T> {
  late int? statusCode;
  late ErrorModel? error;
  late bool valid = false;
  late String? message = '';
  late T? data;
  late T? customError;

  ResponseModel({
    this.valid = false,
    this.message = 'an error occurred please try again',
    this.statusCode = 000,
    this.data,
    this.error,
    this.customError,
  });
}

class ErrorModel {
  dynamic errorCode;
  dynamic message;

  ErrorModel({this.errorCode, this.message});

  @override
  String toString() {
    return '{errorCode: $errorCode, message: $message}';
  }

  factory ErrorModel.fromJson(dynamic data) {
    return ErrorModel(
      errorCode: data['errorCode'] ?? '',
      message: data['message'] ?? '',
    );
  }
}
