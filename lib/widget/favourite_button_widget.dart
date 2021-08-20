import 'package:flutter/material.dart';
import 'package:hackathon_fatura/helper/db_helper.dart';
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
    DBHelper.checkMovieExist(widget.id).then((value){
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
            if(_isFavourite){
              DBHelper.removePraise(widget.id);
              buttonIcon = Icon(Icons.favorite_border);
              _isFavourite = false;
            } else {
              DBHelper.addPraise('movie_table', {
                'id':widget.id,
                'name': widget.name,
                'image': widget.imageUrl
              });
              buttonIcon = Icon(Icons.favorite , color: Colors.red,);
              _isFavourite = true;
            }
          });
        },
        icon: buttonIcon
    );
  }
}
