import 'dart:convert';
import 'package:http/http.dart' as http;

class Requestassistant {
  static Future<dynamic> getRequest(String url) async {
    Uri uri = Uri.parse(url); // Convert String to Uri
    http.Response response = await http.get(uri); // Use the Uri here

    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodeData = jsonDecode(jsonData);
        return decodeData;
      } else {
        return "Failed, No Response.";
      }
    } catch (exp) {
      return "Failed, No Response.";
    }
  }
}
