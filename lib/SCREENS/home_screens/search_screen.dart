import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/fontfaimlly_string.dart';

class SearchScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
 return  SafeArea(child: Scaffold(

   body: Padding(
     padding: EdgeInsets.only(top: 20.0,bottom: 20,left: 28,right: 28),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         const Padding(
           padding: EdgeInsets.only(top: 5.0,right:20,left: 4 ,bottom: 10),
           child: CustomText(text: "SEARCH", color: btnbgColor, fontfamilly: montHeavy,  sizeOfFont: 20),
         ),

         const CustomSearchField(hintText:"Search"),
         const Padding(
           padding: EdgeInsets.only(left: 4.0,top: 30),
           child: CustomText(text: "RECENT SEARCHS", color: btnbgColor, fontfamilly: montHeavy,  sizeOfFont: 20),
         ),
         getView("Surprise Pack","15/02/2023"),
         getView("Surprise Pack","15/02/2023"),
         getView("Surprise Pack","15/02/2023"),
         getView("Surprise Pack","15/02/2023"),
         getView("Surprise Pack","15/02/2023"),
       ],
       ),
   )
 ));
  }
  Widget getView(String title, String viewAllText){

      return Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 7.0,top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: title, color: btntxtColor, fontfamilly: montBold, sizeOfFont: 15),
                CustomText(text: viewAllText, color: graysColor, fontfamilly: montRegular, sizeOfFont: 11,),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top:12.0),
            child: Divider(
              height: 0,
              color: grayColor,
              thickness: 0,

            ),
          )
        ],
      );

  }
}