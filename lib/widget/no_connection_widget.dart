import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('noInternetConnection'.tr().toString() , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.grey),),
    );
  }
}
