import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hackathon_fatura/tasks/third_task/third_task_constants.dart';
import 'package:hackathon_fatura/widget/movie_widget.dart';
import 'package:hackathon_fatura/widget/no_connection_widget.dart';


/* Create a movie mobile application that get popular And recent movies
with an ability to add movie to Favourite list that will be offline
storage on device (use any way you want) that will be displayed
in favorite tabs

- design of this app is attached in project folder
- Adding a progress indicator when information is loading
- Deal with errors coming from the backend (because eventually it will happen!)
- Create model objects for the API data retrieved to avoid working with dynamic (serialisation/deserialisation?)
- Add some sort of state management to show how that is done (InheritedWidget, Provider, GetIt, Mobx and so on)
- add pagination mechanism
 */
class ThirdTaskScreen extends StatefulWidget {
  @override
  _ThirdTaskScreenState createState() => _ThirdTaskScreenState();
}

class _ThirdTaskScreenState extends State<ThirdTaskScreen> with TickerProviderStateMixin{

  late TabController _controller;
  bool _isConnectionStablished = true;

  void checkConnectivity() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        _isConnectionStablished = true;
      });
    } else  {
      setState(() {
        _isConnectionStablished = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnectivity();
    _controller = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(text: 'popular'.tr().toString(),),
            Tab(text: 'topRated'.tr().toString(),),
            Tab(text: 'favourite'.tr().toString(),),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          _isConnectionStablished ? new MovieWidget(ThirdTaskConstants.BaseURL+ThirdTaskConstants.BaseAPIVersion+ThirdTaskConstants.MovieEndpoint+ThirdTaskConstants.TheMovieDBAPIKey): NoConnectionWidget(),
          _isConnectionStablished ? new MovieWidget(ThirdTaskConstants.BaseURL+ThirdTaskConstants.BaseAPIVersion+ThirdTaskConstants.MovieEndpoint+ThirdTaskConstants.TheMovieDBAPIKey+ThirdTaskConstants.TopRatedApi): NoConnectionWidget(),
          Center(child: Text('3'),),
        ],
      ),
    );
  }
}
