import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeaplate/SCREENS/onboarding_screens.dart';
import 'MULTI-PROVIDER/multiproviders.dart';
import 'SCREENS/splash_screen.dart';
import 'UTILS/request_string.dart';
import 'UTILS/utils.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp()); //MyUserList()

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // whenever your initialization is completed, remove the splash screen:
    return getProviders();
  }
}

class AppRoot extends StatelessWidget {
  AppRoot({Key? key}) : super(key: key);

  String status = "";

  void checkLogin() {
    Future.delayed(
      Duration.zero,
          () async {
        String? userId = await Utility.getStringValue(RequestString.USER_ID);
        status = userId ?? "";
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    checkLogin();
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 4)),
        builder: (context, snapshot) =>
        snapshot.connectionState != ConnectionState.done
            ? SplashScreen() //OnBoardingScreen()
            : OnBoardingScreen() //Screen1(),
    );
  }
}
