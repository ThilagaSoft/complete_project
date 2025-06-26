import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient
{
  Future<dynamic> getJson(Uri url) async
  {
    final response = await http.Client().get(url);
    if (response.statusCode != 200)
    {
      throw Exception('Failed request: ${response.statusCode}');
    }
    return json.decode(response.body);
  }
}
