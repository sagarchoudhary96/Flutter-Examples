import 'dart:async';
import 'dart:io';
import 'dart:convert' show json, utf8;

/// List of categories to be fetched from api
const apiCategories = {'name': 'Currency', 'route': 'currency'};

class Api {
  final HttpClient _httpClient = HttpClient();

  final String _url = "flutter.udacity.com";

  /// get the list off units
  Future<List> getUnits(String category) async {
    final uri = Uri.https(_url, '/$category');
    final jsonResponse = await _getJson(uri);

    if (jsonResponse == null || jsonResponse['units'] == null) {
      print("Error retreiving response");
      return null;
    }
    return jsonResponse['units'];
  }

  Future<double> convert(
      String category, String amount, String fromUnit, String toUnit) async {
    final uri = Uri.https(_url, '$category/convert',
        {'amount': amount, 'from': fromUnit, 'to': toUnit});

    final jsonResponse = await _getJson(uri);

    if (jsonResponse == null || jsonResponse['status'] == null) {
      print("Error retreiving conversion");
      return null;
    } else if (jsonResponse["status"] == "error") {
      print(jsonResponse['message']);
      return null;
    }

    return jsonResponse['conversion'].toDouble();
  }

  /// retrieve info from api
  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();

      if (httpResponse.statusCode != HttpStatus.OK) {
        return null;
      }

      final httpResponseBody =
          await httpResponse.transform(utf8.decoder).join();

      return json.decode(httpResponseBody);
    } on Exception catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
