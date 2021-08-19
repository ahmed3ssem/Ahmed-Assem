import 'dart:convert';

import 'package:hackathon_fatura/model/movie_model.dart';
import 'package:hackathon_fatura/tasks/third_task/third_task_constants.dart';
import 'package:http/http.dart' as http;

class MovieProvider{

  static Future<MovieModel> getMovieData()async{
    final url = Uri.parse(ThirdTaskConstants.BaseURL+ThirdTaskConstants.BaseAPIVersion+ThirdTaskConstants.MovieEndpoint+ThirdTaskConstants.TheMovieDBAPIKey);
    final response = await http.get(url);
    if(response.statusCode == 200){
      return MovieModel.fromMap(json.decode(response.body));
    } else {
      return throw Exception('Failed to load List');
    }
  }
}