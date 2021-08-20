import 'dart:convert';
import 'package:hackathon_fatura/model/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieProvider{

  static Future<MovieModel> getMovieData(String apiUrl)async{
    final url = Uri.parse(apiUrl);
    final response = await http.get(url);
    if(response.statusCode == 200){
      return MovieModel.fromMap(json.decode(response.body));
    } else {
      return throw Exception('Failed to load List');
    }
  }
}