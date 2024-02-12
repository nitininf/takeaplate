import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeaplate/SCREENS/onboarding_screen/onboarding_screens.dart';
import 'MULTI-PROVIDER/multiproviders.dart';
import 'SCREENS/splash_screen/splash_screen.dart';
import 'UTILS/PushNotificationService.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();


  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  //
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);





  runApp(const MyApp()); //MyUserList()
// whenever your initialization is completed, remove the splash screen:
  // FlutterNativeSplash.remove();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark));


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  print("FCMToken $fcmToken");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // whenever your initialization is completed, remove the splash screen:
    return getProviders();
  }
}

class AppRoot extends StatefulWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  String status = "";

  void showImage(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () async {},
    );
  }

  @override
  Widget build(BuildContext context) {
    showImage(context);
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) =>
            snapshot.connectionState != ConnectionState.done
                ? SplashScreen() //OnBoardingScreen()
                : const OnBoardingScreen() //Screen1(),
        );
  }
}
