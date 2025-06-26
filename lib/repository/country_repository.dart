import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/country_model.dart';

class CountryRepository
{
  Future<List<Country>> getAllCountries() async
  {
    final url = Uri.parse('https://restcountries.com/v3.1/all?fields=name,cca2,flags');
    print("Get Country");
    print(url);
    try
    {
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200)
      {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => Country.fromJson(e)).toList();
      }
      else
      {
        throw Exception('Failed to load countries');
      }
    }
    catch(e)
    {
      throw Exception(e);

    }

  }
}
