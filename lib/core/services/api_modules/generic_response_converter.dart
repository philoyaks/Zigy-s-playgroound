import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'api_response_model.dart';

class ApiResponseConverter {
  static ResponseModel<T> genericResponseValidation<T>(
      {required Response response,
      required T data,
      String? errordescription,
      T? customError}) {
    int statusCode = response.statusCode ?? 000;

    debugPrint('DDDDDDDDDDDDDDDDDDDDDDDDDDDDD: [INFO] $response');

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel<T>(
          valid: true,
          message: response.statusMessage,
          statusCode: statusCode,
          data: data);
    }

    return ResponseModel(
      valid: false,
      statusCode: response.statusCode,
      message: errordescription ?? response.data["message"],
      error: ErrorModel.fromJson(response.data),
      customError: customError,
    );
  }
}
