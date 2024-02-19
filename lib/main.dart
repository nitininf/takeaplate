import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:take_a_plate/SCREENS/onboarding_screen/onboarding_screens.dart';
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


  Stripe.publishableKey = "pk_test_51OhnPMEZpEOHAybdKjB84iswQCUqYgrKIH8IAgAg5D2dgsk1snSfw4fZpeoT3fk1GWQlS9GlwqQ4h9m5qchcXZHC00v0veYOQ8";

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");



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



  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );


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
