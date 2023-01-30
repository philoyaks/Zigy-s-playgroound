import 'dart:io';

import 'package:dio/dio.dart';

import '../../constants/api_endpoints.dart';

class BackendService {
  final Dio _dio;
  Dio get dio => _dio;

  BackendService(this._dio) {
    initializeDio();
  }

  void initializeDio() {
    _dio.options = BaseOptions(
      baseUrl: ApiEnpoints.baseUrl,
      connectTimeout: 60000,
      receiveTimeout: 60000,
      // set request headers
      headers: {
        "content-Type": "application/json",
      },
    );
  }

  Response? handleError(DioError? e) {
    Response? response;

    switch (e?.type) {
      case DioErrorType.cancel:
        response = Response(
          data: apiResponse(
            message: 'Request cancelled!',
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;
      case DioErrorType.connectTimeout:
        response = Response(
          data: apiResponse(
            message: "Network connection timed out!",
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;
      case DioErrorType.receiveTimeout:
        response = Response(
          data: apiResponse(
            message: "Something went wrong. Please try again later!",
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;
      case DioErrorType.sendTimeout:
        response = Response(
          data: apiResponse(
            message: "Something went wrong. Please try again later",
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;
      case DioErrorType.other:
        if (e?.error is SocketException) {
          response = Response(
            data: apiResponse(
              message: "Please check your network connection!",
            ),
            requestOptions: RequestOptions(path: ''),
          );
        } else if (e?.error is HttpException) {
          response = Response(
            data: apiResponse(
              message: "Network connection issue",
            ),
            requestOptions: RequestOptions(path: ''),
          );
        }
        break;
      default:
        if (e!.response!.data.runtimeType == String &&
            e.error.toString().contains("404")) {
          response = Response(
            data: apiResponse(
              message: "An error occurred, please try again",
              errorCode: '404',
            ),
            requestOptions: RequestOptions(path: ''),
          );
        } else if (e.response?.data.runtimeType == String &&
            e.error.toString().contains("400")) {
          try {
            response = Response(
              data: apiResponse(
                message: e.response?.data["description"] ??
                    "An error occurred, please try again",
                errorCode: '400',
              ),
              requestOptions: RequestOptions(path: ''),
            );
          } catch (e) {
            response = Response(
              data: apiResponse(
                message: "An error occurred, please try again",
                errorCode: '400',
              ),
              requestOptions: RequestOptions(path: ''),
            );
          }
        } else {
          response = Response(
              data: apiResponse(
                  message: e.response!.data.isNotEmpty
                      ? e.response!.data["description"]
                      : "NULL",
                  errorCode: e.response!.data.isNotEmpty
                      ? e.response!.data["errorCode"]
                      : "null"),
              statusCode: e.response?.statusCode ?? 000,
              requestOptions: RequestOptions(path: ''));
        }
    }
    return response;
  }

  apiResponse({dynamic message, dynamic errorCode}) {
    return {
      "message": message ?? "an_error_occurred_please_try_again",
      "errorCode": errorCode ?? "000",
    };
  }
}
