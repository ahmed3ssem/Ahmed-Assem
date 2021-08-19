import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hackathon_fatura/model/movie_model.dart';
import 'package:hackathon_fatura/provider/movie_Provider.dart';
import 'package:hackathon_fatura/tasks/third_task/third_task_constants.dart';


class MovieWidget extends StatefulWidget {

  @override
  _MovieWidgetState createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {

  bool _isLoading = true;
  late MovieModel _model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MovieProvider.getMovieData().then((value){
      setState(() {
        _model = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Center(child: CircularProgressIndicator(),) : GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(_model.results.length , (index){
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    child: CachedNetworkImage(
                      imageUrl: ThirdTaskConstants.BaseImagePath+_model.results[index].backdropPath,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                      errorWidget: (context, url, error) => Center(child: Icon(Icons.error , color: Colors.blue,),),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_model.results[index].title , style: TextStyle(fontWeight: FontWeight.bold),),
                      IconButton(onPressed: (){}, icon: Icon(Icons.favorite , color: Colors.red,))
                    ],
                  )
                ],
              ),
            ),
          );
        })
    );
  }
}
