import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hackathon_fatura/model/movie_model.dart';
import 'package:hackathon_fatura/provider/movie_Provider.dart';
import 'package:hackathon_fatura/tasks/third_task/third_task_constants.dart';
import 'package:hackathon_fatura/widget/favourite_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';


class MovieWidget extends StatefulWidget {

  String apiUrl = '';


  MovieWidget(this.apiUrl);

  @override
  _MovieWidgetState createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {

  bool _isLoading = true;
  late MovieModel _model;
  Icon icon = Icon(Icons.favorite_border);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MovieProvider>(context , listen: false).getMovieData(widget.apiUrl).then((value){
      setState(() {
        _model = value;
        _isLoading = false;
      });
    }).catchError((_){
      setState(() {
        _isLoading = false;
        final snackBar = SnackBar(
          content: Text('failedToLoad'.tr().toString()),
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            textColor: Colors.white,
            label: 'ok'.tr().toString(),
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    return _isLoading ? Center(child: CircularProgressIndicator(),) :
    GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        children: List.generate(_model.results.length , (index){
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl(_model.results[index].backdropPath),
                      placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                      errorWidget: (context, url, error) => Center(child: Icon(Icons.error , color: Colors.blue,),),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        child: Text(_model.results[index].title ?? "" , style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      FavouriteButtonWidget(_model.results[index].id , _model.results[index].backdropPath ?? "" , _model.results[index].title ?? "")
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
