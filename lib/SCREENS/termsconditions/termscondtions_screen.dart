import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/MULTI-PROVIDER/TermsAndConditionsProvider.dart';
import 'package:takeaplate/Response_Model/TermsAndConditionsResponse.dart';

import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/fontfamily_string.dart';

class TermsAndConditionScreen extends StatelessWidget{
  final TermsAndConditionsProvider privacyPolicyProvider = TermsAndConditionsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0,bottom: 20,left: 29,right: 29),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(),
              SizedBox(height: 20,),
              hitApi()
            ],
          ),
        ),
      ),
    );
  }

  Widget hitApi() {

    return FutureBuilder<TermsAndConditionsResponse>(
      future: privacyPolicyProvider.getPrivacyPolicyData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Center the loading indicator

        } else if (snapshot.hasError) {
          return Text('Failed to fetch terms and condition data. Please try again.');

        } else if (snapshot.hasData) {
          // Display HTML data
          return getView(snapshot.data?.data ?? '');
        } else {
          return Text("No data available");
        }
      },
    );
  }


  Widget getView(String s){
    return  Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(child: CustomText(text: "TERMS & CONDITIONS",sizeOfFont: 20,fontfamilly: montHeavy,color: editbgColor,),
                onTap: (){
                  // Navigator.pushNamed(context, '/TermsAndConditionScreen');
                },),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                    color: faqSelectedColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: Colors.white)),
                child:  HtmlWidget(s),
              ),
            ],),
        ),
      ),
    );
  }

}