import 'package:flutter/material.dart';
import 'package:hackathon_fatura/helper/save_offline.dart';

class FavouriteButtonWidget extends StatefulWidget {
  //const FavouriteButtonWidget({Key? key}) : super(key: key);

  int id = 0;
  String imageUrl = '';
  String name = '';


  FavouriteButtonWidget(this.id, this.imageUrl, this.name);

  @override
  _FavouriteButtonWidgetState createState() => _FavouriteButtonWidgetState();
}

class _FavouriteButtonWidgetState extends State<FavouriteButtonWidget> {
  Icon buttonIcon = Icon(Icons.favorite_border);
  bool _isFavourite = false;
  List<String> movieData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SaveFavouriteOffline.checkMovieExist(widget.id).then((value){
      setState(() {
        if(value){
          buttonIcon = Icon(Icons.favorite , color: Colors.red,);
          _isFavourite = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          setState(() {
            SaveFavouriteOffline.removeMovie(widget.id);
            if(_isFavourite){
              buttonIcon = Icon(Icons.favorite_border);
              _isFavourite = false;
            } else {
              movieData.add(widget.name);
              movieData.add(widget.imageUrl);
              SaveFavouriteOffline.addMovie(widget.id, movieData);
              buttonIcon = Icon(Icons.favorite , color: Colors.red,);
              _isFavourite = true;
              SaveFavouriteOffline.messi();
            }
          });
        },
        icon: buttonIcon
    );
  }
}
