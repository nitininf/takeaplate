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
     padding: EdgeInsets.all(20.0),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         const Padding(
           padding: EdgeInsets.only(top: 5.0,right:20,left: 20 ,bottom: 10),
           child: CustomText(text: "SEARCH", color: btnbgColor, fontfamilly: montBold, weight: FontWeight.w900, sizeOfFont: 17),
         ),
         const SizedBox(height: 10),
         const CustomSearchField(hintText:"Search"),
         const Padding(
           padding: EdgeInsets.only(left: 10.0,top: 30),
           child: CustomText(text: "RECENT SEARCHS", color: btnbgColor, fontfamilly: montBold, weight: FontWeight.w900, sizeOfFont: 17),
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

      return Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: title, color: btntxtColor, fontfamilly: montBold, weight: FontWeight.w500, sizeOfFont: 13),
                CustomText(text: viewAllText, color: Colors.black, fontfamilly: montLight, weight: FontWeight.w300,sizeOfFont: 11,),
              ],
            ),
             const Padding(
              padding: EdgeInsets.only(top:20.0),
              child: Divider(
                height: 0,
                color: grayColor,
                thickness: 0,

              ),
            )
          ],
        ),
      );

  }
}