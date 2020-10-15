import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static String baseUrl = "";
  static String _properties = "/";

  Future<dynamic> get(String url) async {
    print("API get at url: " + baseUrl + _properties);
    var responseJSON;
    var response;
    try {
      final response = await http.get(url);
      responseJSON = _returnResponse(response);
    } on SocketException {
      print("Internet Not Working");
    }
    return responseJSON;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var jsonresponse = json.decode(response.body.toString());
      return jsonresponse;
    case 400:
      print("Bad Request");
      break;
    case 401:
      print("Unauthoried");
      break;
  }
}
