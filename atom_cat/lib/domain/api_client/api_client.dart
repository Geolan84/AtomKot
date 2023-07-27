import 'dart:async';


enum ApiClientExceptionType { noAnswer, network, auth, other, sessionExpired }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {

  static const hostLink = '10.0.2.2:8080';

  Future<Map<String, dynamic>> auth({required String email, required String password,}) async {
    var result = <String, dynamic>{};
    result["token"] = "token";
    result["user_id"] = "user_id";
    return result;
  }
}