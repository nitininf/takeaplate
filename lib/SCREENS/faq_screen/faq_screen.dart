import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../MULTI-PROVIDER/FaqProvider.dart';
import '../../Response_Model/FaqResponse.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

class FaqScreenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FaqProvider faqProvider = FaqProvider();

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(),
              SizedBox(height: 10,),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CustomText(
                    text: "FAQ'S",
                    color: editbgColor,
                    sizeOfFont: 20,
                    fontfamilly: montHeavy,
                  ),
                ),
                onTap: () {
                  //  Navigator.pushNamed(context, '/SettingScreen');
                },
              ),
              SizedBox(height: 10,),
              buildVerticalCards(faqProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVerticalCards(FaqProvider faqProvider) {
    return FutureBuilder<FaqResponse>(
      future: faqProvider.fetchFaqData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data?.data == null) {
          return Text('FAQ data not available');
        } else {
          print("FAQ Data: ${snapshot.data?.data}"); // Add this line for debugging
          return Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: snapshot.data!.data!.map((faq) => getExpandable(faqData: faq, collapse: true)).toList(),
              ),
            ),
          );
        }
      },
    );
  }


  Widget getExpandable({required Data faqData, required bool collapse}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.grey),
        ),
        elevation: 0,
        child: ExpandableNotifier(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: collapse ? Colors.white : Colors.red,
            ),
            child: ScrollOnExpand(
              child: ExpandablePanel(
                header: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: faqData.questions ?? "Default Question",
                      color: editbgColor,
                      sizeOfFont: 17,
                      fontfamilly: montRegular,
                    ),
                  ),
                ),
                expanded: Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomText(
                    text: faqData.answers ?? "Lorem ipsum dolor sit amet...",
                    color: editbgColor,
                    sizeOfFont: 17,
                    fontfamilly: montRegular,
                  ),
                ),
                theme: const ExpandableThemeData(
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                ), collapsed:  SizedBox(

                ),

              ),
            ),
          ),
        ),
      ),
    );
  }



}
