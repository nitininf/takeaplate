import 'package:flutter/material.dart';
import '../SCREENS/closet_screen/closest_screen.dart';
import '../SCREENS/contact_us/contacctus_settings.dart';
import '../SCREENS/contact_us/contact_us.dart';
import '../SCREENS/edit_profile/edit_profile.dart';
import '../SCREENS/faq_screen/faq_screen.dart';
import '../SCREENS/favourite_screen/favourite_screen.dart';
import '../SCREENS/home_screens/base_home.dart';
import '../SCREENS/home_screens/my_orders.dart';
import '../SCREENS/home_screens/orderandpay.dart';
import '../SCREENS/home_screens/paymentdetails.dart';
import '../SCREENS/home_screens/restrurent.dart';
import '../SCREENS/notification/NotifcattionTurnOnScreen.dart';
import '../SCREENS/notification/notification_center.dart';
import '../SCREENS/notification/your_notifcation.dart';
import '../SCREENS/order_summery/order_summery.dart';
import '../SCREENS/privacy_policy/privacypolicy_screen.dart';
import '../SCREENS/reestrurent_profile/restrorent_profile.dart';
import '../SCREENS/setting_screen/settings_screen.dart';
import '../SCREENS/signup_flow/SignupScreen.dart';
import '../SCREENS/login_flow/CreateOrLoginScreen.dart';
import '../SCREENS/login_flow/LoginScreen.dart';
import '../SCREENS/login_flow/PasswordSentMail.dart';
import '../SCREENS/signup_flow/setyourpass.dart';
import '../SCREENS/signup_flow/upload_photo.dart';
import '../SCREENS/termsconditions/termscondtions_screen.dart';
import '../SCREENS/your_order/your_order.dart';
import '../UTILS/app_color.dart';
import '../UTILS/app_strings.dart';
import '../main.dart';
import '../payment_method/paymentmethod_screen.dart';
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
        '/FaqScreenScreen': (context) => FaqScreenScreen(),
        '/EditProfileScreen': (context) => EditProfileScreen(),
        '/ContactUs': (context) => ContactUs(),
        '/ContactUsSetting': (context) => ContactUsSetting(),
        '/ClosestScreen': (context) => ClosestScreen(),
        '/NotificationCenterScreen': (context) => NotificationCenterScreen(),
        '/YourNotificationScreen': (context) => YourNotificationScreen(),
        '/PrivacyPolicyScreen': (context) => PrivacyPolicyScreen(),
        '/TermsAndConditionScreen': (context) => TermsAndConditionScreen(),
        '/SettingScreen': (context) => SettingScreen(),
        '/YourOrderScreen': (context) => YourOrderScreen(),
        '/FavouriteScreen': (context) => FavouriteScreen(),
        '/OrderSummeryScreen': (context) => OrderSummeryScreen(),
        '/PaymentMethodScreen': (context) => PaymentMethodScreen(),
        '/RestrorentProfileScreen': (context) => RestrorentProfileScreen(),
      },
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: btnbgColor),
          useMaterial3: true,

          fontFamily: "Mont"),
      // home: AppRoot(),
    ),
  );
}
