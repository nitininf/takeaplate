import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_text_field.dart';
import '../UTILS/app_color.dart';
import 'package:page_indicator/page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late int index = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          appBackground,
          fit: BoxFit.cover,
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: screenHeight * 0.09,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: CustomText(
                    text: skip,
                    sizeOfFont: 13,
                    color: Colors.white,
                    fontfamilly: montBold,
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                appLogo,
                height: 120,
                width: 120,
              ),
            ),
            SizedBox(height: screenHeight*0.05,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                    color: editbgColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: Colors.white)),
                child: Column(children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  SizedBox(
                    height: screenHeight * 0.32,
                    width: screenWidth,
                    child: PageIndicatorContainer(
                      align: IndicatorAlign.bottom,
                      length: 3,
                      indicatorSpace: 3.0,
                      padding: const EdgeInsets.all(10),
                      indicatorColor: Colors.white30,
                      indicatorSelectorColor: btnbgColor,
                      shape: IndicatorShape.circle(size: 12),
                      child: PageView.builder(
                          controller: _pageController,
                          itemCount: 3,
                          onPageChanged: (value) {
                            setState(() {
                              index = value;
                            });
                          },
                          itemBuilder: (context, position) {
                            return index == 0
                                ? const SliderWidget(
                                    title: dinesmart,
                                    description:enjoyExclusive ,
                                    headingColor: btnbgColor,
                                    image: onboarding_one,
                                  )
                                : index == 1
                                    ? SliderWidget(
                                        title: ecoeats,
                                        description: helpResttrutent,
                                        headingColor: index == 1
                                            ? btnbgColor
                                            : btnbgColor,
                                    image: onboarding_two,
                                      )
                                    : const SliderWidget(
                                        title: flavoredResttrutent,
                                        description: delight,
                                        headingColor: btnbgColor,
                              image: onboarding_three,
                                      );
                          }),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth,
                    height: 55,
                    child:
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0,left: 20),
                      child: CommonButton(
                        btnBgColor: index == 1 ? onboardingBtn : onboardingBtn,
                        btnTextColor: btntxtColor,
                        btnText: next,
                        onClick: () {
                          if (index < 2) {
                            _pageController.animateToPage(
                              (_pageController.page ?? 0).toInt() + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear,
                            );
                          } else {
                              Navigator.pushNamed(context, '/Create_Login');
                              }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                ]),
              ),
            ),
            const Spacer(),
          ],
        ),
      ]),
    );
  }
}

class SliderWidget extends StatelessWidget {
  const SliderWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.headingColor,
      required this.image});

  final String title;
  final String description;
  final Color headingColor;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Align(
          alignment: Alignment.center,
          child: Image.asset(image,
          height: 50,
          width: 50,),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: montitalic,
            fontSize: 18,
            color: headingColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
         SingleChildScrollView(
          child: Text(
           description!,
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.white, height: 1.4, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
