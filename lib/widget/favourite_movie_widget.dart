import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_fatura/helper/db_helper.dart';
import 'package:hackathon_fatura/helper/save_offline.dart';
import 'package:hackathon_fatura/tasks/third_task/third_task_constants.dart';

class FavouriteMovieWidget extends StatefulWidget {
  const FavouriteMovieWidget({Key? key}) : super(key: key);

  @override
  _FavouriteMovieWidgetState createState() => _FavouriteMovieWidgetState();
}

class _FavouriteMovieWidgetState extends State<FavouriteMovieWidget> {

  List<dynamic> favouriteMovies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DBHelper.getData('movie_table').then((value){
      setState(() {
       favouriteMovies = value;
      });
    });

  }

  String imageUrl(String? url){
    if(url == null){
      return "";
    } else {
      return ThirdTaskConstants.BaseImagePath+url;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        children: List.generate(favouriteMovies.length , (index){
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl(favouriteMovies[index]['image']),
                      placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                      errorWidget: (context, url, error) => Center(child: Icon(Icons.error , color: Colors.blue,),),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: const EdgeInsets.only(right: 10 , left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          child: Text(favouriteMovies[index]['name'] ?? "" , style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        })
    );
  }
}
