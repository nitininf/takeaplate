import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';

class ClosestScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body: Column(
        children: [
          CustomAppBar(),
          SearchBar(),
          
        ],
      ),
    ));
  }

}