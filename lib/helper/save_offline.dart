import 'package:shared_preferences/shared_preferences.dart';

class SaveFavouriteOffline{

  static Future<void> addMovie(int id , List<String> movieList) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(id.toString(), movieList);
  }

  static Future<void> removeMovie(int id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(id.toString());
  }

  static Future<bool> checkMovieExist(int id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(id.toString())){
      return true;
    } else {
      return false;
    }
  }

  static Future<void> messi() async{
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final prefsMap = Map<String, dynamic>();
    for(String key in keys) {
      prefsMap[key] = prefs.get(key);
    }
    print(prefsMap);
  }
}

