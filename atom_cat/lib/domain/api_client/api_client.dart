import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum ApiClientExceptionType { noAnswer, network, auth, other, sessionExpired }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {

  static const hostLink = '10.0.2.2:8080';

  static const geoDecoder = 'suggestions.dadata.ru';

  Future<Map<String, dynamic>> auth({required String email, required String password,}) async {
    var result = <String, dynamic>{};
    result["token"] = "token";
    result["user_id"] = "user_id";
    return result;
  }

  Future<String> getGeoAddress(double lat, double lon, int radius) async{
    // print("$lat, $lon");
    try {
      var url = Uri.http(geoDecoder, 'suggestions/api/4_1/rs/geolocate/address');
      var body = json.encode({"lat": lat, "lon": lon, "radius_meters": radius});
      var response = await http
          .post(url, headers: {"Content-Type": "application/json", "Accept": "application/json", "Authorization": "Token 79d5fbee680958eea83c89d08a8ac450cd306082",}, body: body)
          .timeout(
            const Duration(seconds: 5),
          );
      var js = json.decode(response.body);
      if(js["suggestions"].length != 0){
        return js["suggestions"][0]["value"].toString();
      }
      return "Не удалось определить адрес";
    } on TimeoutException {
      return "Не удалось определить адрес";
    }
  }
}