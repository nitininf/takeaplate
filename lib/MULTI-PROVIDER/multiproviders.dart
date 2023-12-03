import 'package:flutter/material.dart';
import '../SCREENS/home_screens/base_home.dart';
import '../SCREENS/home_screens/my_orders.dart';
import '../SCREENS/home_screens/orderandpay.dart';
import '../SCREENS/home_screens/paymentdetails.dart';
import '../SCREENS/home_screens/restrurent.dart';
import '../SCREENS/notification/NotifcattionTurnOnScreen.dart';
import '../SCREENS/signup_flow/SignupScreen.dart';
import '../SCREENS/login_flow/CreateOrLoginScreen.dart';
import '../SCREENS/login_flow/LoginScreen.dart';
import '../SCREENS/login_flow/PasswordSentMail.dart';
import '../SCREENS/signup_flow/setyourpass.dart';
import '../SCREENS/signup_flow/upload_photo.dart';
import '../UTILS/app_color.dart';
import '../UTILS/app_strings.dart';
import '../main.dart';
import 'common_counter.dart';
import 'package:provider/provider.dart';
MultiProvider getProviders() {

  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CommonCounter()),
    ],
    child:
    MaterialApp(
      title: appName,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>  AppRoot(),
        '/Create_Login': (context) => CreateOrLogInScreen(),
        '/Login': (context) => LogInScreen(),
        '/PassWordSentScreen': (context) => PassWordSentScreen(),
        '/SignupScreen': (context) => SignUpScreen(),
        '/UploadPhoto': (context) => UploadPhoto(),
        '/SetYourPasswordScreen': (context) => SetYourPasswordScreen(),
        '/NotificationTurnOnScreen': (context) => NotificationTurnOnScreen(),
        '/BaseHome': (context) => BaseHome(),
        '/OrderAndPayScreen': (context) => OrderAndPayScreen(),
        '/PaymentDetailsScreen': (context) => PaymentDetailsScreen(),
        '/RestrurentScreen': (context) => RestrurentScreen(),
        '/MyOrdersSccreen': (context) => MyOrdersSccreen(),
      },
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: btnbgColor),
          useMaterial3: true,
          fontFamily: "Mont"),
      // home: AppRoot(),
    ),
  );
}
