import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hackathon_fatura/model/movie_model.dart';
import 'package:http/http.dart' as http;


class MovieProvider extends ChangeNotifier{

   Future<MovieModel> getMovieData(String apiUrl)async{
    final url = Uri.parse(apiUrl);
    final response = await http.get(url);
    if(response.statusCode == 200){
      notifyListeners();
      return MovieModel.fromMap(json.decode(response.body));
    } else {
      return throw Exception('Failed to load List');
    }
  }
}