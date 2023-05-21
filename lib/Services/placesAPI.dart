import 'package:code_silver/Models/searchResult.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class NearYouAPI {
  Future<SearchResult?> getResult() async {
    final Uri url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/textsearch/json?key="add key",79.1559&query=hospital&type=health&radius=2000");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return searchResultFromJson(response.body);
    } else {
      return null;
    }
  }
}
