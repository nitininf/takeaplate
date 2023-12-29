import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomText(
                  text: "FAQ'S",
                  color: editbgColor,
                  sizeOfFont: 20,
                  fontfamilly: montHeavy,
                ),
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
            child: ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0), // Adjust the value according to your preference
                  child: ExpandablePanelWidget(faqData: snapshot.data!.data![index], collapse: true),
                );
              },
            ),
          );
        }
      },
    );
  }



}

class ExpandablePanelWidget extends StatefulWidget {
  final Data faqData;
  final bool collapse;

  const ExpandablePanelWidget({Key? key, required this.faqData, required this.collapse}) : super(key: key);

  @override
  _ExpandablePanelWidgetState createState() => _ExpandablePanelWidgetState();
}

class _ExpandablePanelWidgetState extends State<ExpandablePanelWidget> {
  late ExpandableController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ExpandableController(initialExpanded: !widget.collapse);
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      controller: _controller,
      child: Builder(
        builder: (context) {
          return Container(
            decoration: _getContainerDecoration(),
            child: ScrollOnExpand(
              child: ExpandablePanel(
                header: Builder(
                  builder: (BuildContext context) {
                    return ListTile(
                      title: CustomText(
                        text: widget.faqData.questions ?? "Default Question",
                        color: _getTextColor(),

                        sizeOfFont: 17,
                        fontfamilly: montBold,
                      ),
                      onTap: () {
                        setState(() {
                          _controller.toggle();
                          print("Expanded: ${_controller.expanded}");
                        });

                      },
                    );
                  },
                ),
                expanded: Padding(
                  padding: EdgeInsets.only(right: 20,left: 20,top: 0,bottom: 20),
                  child: CustomText(
                    text: widget.faqData.answers ?? "Lorem ipsum dolor sit amet...",
                    color: editbgColor,
                    sizeOfFont: 17,
                    fontfamilly: montRegular,
                  ),
                ),
                theme: const ExpandableThemeData(
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                ),
                collapsed: SizedBox(),
              ),
            ),
          );
        }
      ),
    );
  }
  Color _getContainerColor() {
    return _controller.expanded ? Color(0x76f8b097) : Colors.white;
  }

  Color _getTextColor() {
    return _controller.expanded ? Color(0xfff39474) : Colors.black;
  }

  BoxDecoration _getContainerDecoration() {
    return _controller.expanded ? BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: _getContainerColor(),

    ):BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: _getContainerColor(),
      border: Border.all(
        color: Colors.black, // Set the border color to black
        width: 1.0, // Set the border width
      ),
    );
  }
}






