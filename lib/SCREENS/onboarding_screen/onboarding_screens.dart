import 'package:flutter/material.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:take_a_plate/UTILS/app_images.dart';
import 'package:take_a_plate/UTILS/app_strings.dart';
import 'package:take_a_plate/UTILS/fontfamily_string.dart';
import '../../CUSTOM_WIDGETS/common_button.dart';
import '../../UTILS/app_color.dart';
import 'package:page_indicator/page_indicator.dart';
import '../../UTILS/request_string.dart';
import '../../UTILS/utils.dart';

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
            Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.09,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () async {
                          int? userId =
                              await Utility.getIntValue(RequestString.ID);

                          if (userId != null) {
                            Navigator.pushNamed(context, '/BaseHome');
                          } else {
                            Navigator.pushNamed(context, '/Create_Login');
                          }
                        },
                        child: const CustomText(
                          text: skip,
                          sizeOfFont: 13,
                          color: Colors.white,
                          fontfamilly: montBold,
                        ),
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
                SizedBox(
                  height: screenHeight * 0.05,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40, bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                  color: onboardingbgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: Colors.white)),
              child: Column(children: [
                SizedBox(
                  height: screenHeight * 0.38,
                  child: PageIndicatorContainer(
                    align: IndicatorAlign.bottom,
                    length: 0,
                    indicatorSpace: 3.0,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    indicatorColor: Colors.transparent,
                    //btnbgColor.withOpacity(0.5),
                    indicatorSelectorColor: Colors.transparent,
                    //btnbgColor,
                    shape: IndicatorShape.circle(size: 10),
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
                                  description: enjoyExclusive,
                                  headingColor: btnbgColor,
                                  image: onboarding_one,
                                )
                              : index == 1
                                  ? SliderWidget(
                                      title: ecoeats,
                                      description: helpResttrutent,
                                      headingColor:
                                          index == 1 ? btnbgColor : btnbgColor,
                                      image: onboarding_two,
                                    )
                                  : const SliderWidget(
                                      title: flavoredRestaurant,
                                      description: delight,
                                      headingColor: btnbgColor,
                                      image: onboarding_three,
                                    );
                        }),
                  ),
                ),

                // Dots
                SizedBox(
                  height: screenHeight * 0.020,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3, // Number of pages
                    (index) => buildDot(index),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.020,
                ),
                SizedBox(
                  width: screenWidth,
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20),
                    child: CommonButton(
                      btnBgColor: index == 1 ? onboardingBtn : onboardingBtn,
                      btnTextColor: btntxtColor,
                      btnText: next,
                      onClick: () async {
                        if (index < 2) {
                          _pageController.animateToPage(
                            (_pageController.page ?? 0).toInt() + 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        } else {
                          int? userId =
                              await Utility.getIntValue(RequestString.ID);

                          if (userId != null) {
                            Navigator.pushNamed(context, '/BaseHome');
                          } else {
                            Navigator.pushNamed(context, '/Create_Login');
                          }
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ]),
            ),
          ],
        ),
      ]),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == index ? btnbgColor : btnbgColor.withOpacity(0.5),
      ),
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 4,
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              image,
              height: 70,
              width: 68,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontFamily: montHeavy,
              fontSize: 18,
              color: headingColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 7,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              description,
              textAlign: TextAlign.center,
              // maxLines: 4,
                overflow: TextOverflow.clip,
              style: const TextStyle(
                  color: Colors.white,
                  height: 1.4,
                  fontSize: 16,
                  fontFamily: montRegular),
            ),
          ),
        ],
      ),
    );
  }
}
