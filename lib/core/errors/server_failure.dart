import 'package:dio/dio.dart';

class ServerFailure {
  String errMessage;

  ServerFailure({required this.errMessage});

  factory ServerFailure._badResponse({
    required int statusCode,
    required dynamic response,
  }) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      if (response['customer_exists'] != null) {
        return ServerFailure(errMessage: "هذا الرقم مسجل من قبل كمستخدم"); 
      }
      if (response['agent_exists'] != null) {
        return ServerFailure(errMessage: "هذا الرقم مسجل من قبل كوكيل"); 
      }
      return ServerFailure(
          errMessage: (response['message'] is String)
              ? response['message']
              : response['message'][0]);
    } else if (statusCode == 500) {
      return ServerFailure(errMessage: 'Internal Server Error');
    } else if (statusCode == 404) {
      return ServerFailure(errMessage: '404 Page Not Found');
    } else {
      return ServerFailure(
        errMessage: 'Oops unexpected error occurred, Please try again',
      );
    }
  }

  factory ServerFailure.fromDioException({
    required DioException dioException,
  }) {
    switch (dioException.type) {
      //connection between client and server timeout
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errMessage: 'Server connection timeout. Please try again.',
        );
      //the client sends data to the server,
      //but the server does not respond within the specified time limit
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          errMessage:
              'Sending data to server takes too much time, check your internet connection.',
        );
      //the client is waiting to receive data from the server,
      // but the server does not send a response within the specified time limit
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          errMessage:
              'Receiving data from server takes too much time, check your internet connection.',
        );
      //there is an error in the network
      case DioExceptionType.connectionError:
        return ServerFailure(errMessage: 'No internet connection');
      //the request cancelled by the user
      case DioExceptionType.cancel:
        return ServerFailure(
            errMessage: 'Request cancelled. Please try again.');
      //the error have a response
      case DioExceptionType.badResponse:
        return ServerFailure._badResponse(
          statusCode: dioException.response!.statusCode!,
          response: dioException.response!.data,
        );
      //there is a security or privacy issues
      case DioExceptionType.badCertificate:
        return ServerFailure(
          errMessage:
              'Your connection is not private. The server\'s SSL certificate is not valid. Proceed with caution',
        );
      //the default errMessage
      default:
        return ServerFailure(
          errMessage: 'Oops unexpected error occurred, Please try again',
        );
    }
  }
}
