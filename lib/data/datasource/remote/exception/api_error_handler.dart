import 'package:dio/dio.dart';
import 'package:learnjava/data/model/response/base/error_response.dart';

import '../../../../utill/app_constants.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {

      try {
        if (error is DioError) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioExceptionType.unknown:
              errorDescription =
              "Connection to API server failed due to internet connection";
              break;
            case DioExceptionType.receiveTimeout:
              errorDescription =
              "Receive timeout in connection with API server";
              break;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 404:
                case 500:
                case 503:
                  errorDescription = error.response!.statusMessage;
                  break;
                default:
                  ErrorResponse errorResponse =
                  ErrorResponse.fromJson(error.response!.data);
                  logger.i(errorResponse.toJson());
                  if (errorResponse.errors != null &&
                      errorResponse.errors!.isNotEmpty) {
                    errorDescription = errorResponse.errors![0].message;
                  } else {
                    errorDescription =
                    "Failed to load data - status code: ${error.response!.statusCode}";
                  }
              }
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
            case DioExceptionType.badCertificate:
            // TODO: Handle this case.
            case DioExceptionType.connectionError:
            // TODO: Handle this case.
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    logger.i(errorDescription);
    return errorDescription;
  }
}
