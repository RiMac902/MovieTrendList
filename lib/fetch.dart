import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = '96415b7ebfab1ef8e5aef8530a66644c';
const String baseUrl = 'https://api.themoviedb.org/3';

Future<List<dynamic>> fetchMovies(int page) async {
  final String apiUrl = '$baseUrl/movie/popular?api_key=$apiKey&page=$page';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return jsonResponse['results'];
  } else {
    throw Exception('Failed to load movies');
  }
}
