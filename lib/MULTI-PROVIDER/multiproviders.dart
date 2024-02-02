import 'package:flutter/material.dart';
import 'package:takeaplate/MULTI-PROVIDER/ContactUsProvider.dart';
import 'package:takeaplate/MULTI-PROVIDER/DateProvider.dart';
import 'package:takeaplate/MULTI-PROVIDER/GenderProvider.dart';
import 'package:takeaplate/MULTI-PROVIDER/AuthenticationProvider.dart';
import 'package:takeaplate/MULTI-PROVIDER/RestaurantsListProvider.dart';
import 'package:takeaplate/MULTI-PROVIDER/SignUp_StepOne.dart';
import 'package:takeaplate/MULTI-PROVIDER/selectImageProvider.dart';
import 'package:takeaplate/SCREENS/last_minute_deal/last_minute_deal_screen.dart';
import '../SCREENS/closet_screen/closest_screen.dart';
import '../SCREENS/collect_tomorrow/collect_tomorrow_screen.dart';
import '../SCREENS/contact_us/contacctus_settings.dart';
import '../SCREENS/contact_us/contact_us.dart';
import '../SCREENS/edit_profile/edit_profile.dart';
import '../SCREENS/faq_screen/faq_screen.dart';
import '../SCREENS/favourite_screen/favourite_screen.dart';
import '../SCREENS/forgot_password/ForgotPasswordScreen.dart';
import '../SCREENS/home_screens/base_home.dart';
import '../SCREENS/home_screens/my_orders.dart';
import '../SCREENS/home_screens/orderandpay.dart';
import '../SCREENS/home_screens/paymentdetails.dart';
import '../SCREENS/home_screens/restrurent.dart';
import '../SCREENS/home_screens/search_screen.dart';
import '../SCREENS/notification/NotifcattionTurnOnScreen.dart';
import '../SCREENS/notification/notification_center.dart';
import '../SCREENS/notification/your_notifcation.dart';
import '../SCREENS/order_summery/order_summery.dart';
import '../SCREENS/previous_orders/previous_orders_screen.dart';
import '../SCREENS/privacy_policy/privacypolicy_screen.dart';
import '../SCREENS/reestrurent_profile/restrorent_profile.dart';
import '../SCREENS/search_screen/search_result_screen.dart';
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
import 'CartOperationProvider.dart';
import 'FaqProvider.dart';
import 'FavCardsProvider.dart';
import 'FavoriteOperationProvider.dart';
import 'HomeDataListProvider.dart';
import 'NotificationProvider.dart';
import 'OrderAndPayProvider.dart';
import 'OrderProvider.dart';
import 'PaymentDetailsProvider.dart';
import 'PlaceListProvider.dart';
import 'PrivacyPolicyProvider.dart';
import 'SearchProvider.dart';
import 'SignUp_StepTwo.dart';
import 'TermsAndConditionsProvider.dart';
import 'common_counter.dart';
import 'package:provider/provider.dart';
MultiProvider getProviders() {

  return MultiProvider(

    providers: [
      ChangeNotifierProvider(create: (_) => CommonCounter()),
      ChangeNotifierProvider(create: (_) => DateProvider()),
      ChangeNotifierProvider(create: (_) => GenderProvider()),
      ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ChangeNotifierProvider(create: (_) => SelectImageProvider()),
      ChangeNotifierProvider(create: (_) => SignUp_StepOne()),
      ChangeNotifierProvider(create: (_) => SignUp_StepTwo()),
      ChangeNotifierProvider(create: (_) => PlaceListProvider()),
      ChangeNotifierProvider(create: (_) => FavCardsProvider()),
      ChangeNotifierProvider(create: (_) => CartOperationProvider()),
      ChangeNotifierProvider(create: (_) => ContactUsProvider()),
      ChangeNotifierProvider(create: (_) => FaqProvider()),
      ChangeNotifierProvider(create: (_) => OrderAndPayProvider()),
      ChangeNotifierProvider(create: (_) => RestaurantsListProvider()),
      ChangeNotifierProvider(create: (_) => PrivacyPolicyProvider()),
      ChangeNotifierProvider(create: (_) => TermsAndConditionsProvider()),
      ChangeNotifierProvider(create: (_) => FavoriteOperationProvider()),
      ChangeNotifierProvider(create: (_) => HomeDataListProvider()),
      ChangeNotifierProvider(create: (_) => PaymentDetailsProvider()),
      ChangeNotifierProvider(create: (_) => OrderProvider()),
      ChangeNotifierProvider(create: (_) => SearchProvider()),
      ChangeNotifierProvider(create: (_) => NotificationProvider()),

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
        '/ForgotPasswordScreen': (context) => ForgotPasswordScreen(),
        '/PassWordSentScreen': (context) => PassWordSentScreen(),
        '/SignupScreen': (context) => SignUpScreen(),
        '/UploadPhoto': (context) => UploadPhoto(),
        '/SetYourPasswordScreen': (context) => SetYourPasswordScreen(),
        '/NotificationTurnOnScreen': (context) => NotificationTurnOnScreen(),
        '/BaseHome': (context) => BaseHome(),
        '/OrderAndPayScreen': (context) => OrderAndPayScreen(),
        '/PaymentDetailsScreen': (context) => PaymentDetailsScreen(),
        '/RestaurantsScreen': (context) => RestaurantsScreen(),
        '/MyOrdersScreen': (context) => MyOrdersScreen(),
        '/FaqScreenScreen': (context) => FaqScreenScreen(),
        '/EditProfileScreen': (context) => EditProfileScreen(),
        '/ContactUs': (context) => ContactUs(),
        '/ContactUsSetting': (context) => ContactUsSetting(),
        '/ClosestScreen': (context) => ClosestScreen(),
        '/LastMinuteDealScreen': (context) => LastMinuteDealScreen(),
        '/NotificationCenterScreen': (context) => NotificationCenterScreen(),
        '/YourNotificationScreen': (context) => YourNotificationScreen(),
        '/PrivacyPolicyScreen': (context) => PrivacyPolicyScreen(),
        '/TermsAndConditionScreen': (context) => TermsAndConditionScreen(),
        '/SettingScreen': (context) => SettingScreen(),
        '/YourOrderScreen': (context) => YourOrderScreen(),
        '/FavouriteScreen': (context) => FavouriteScreen(),
        '/OrderSummeryScreen': (context) => OrderSummeryScreen(),
        '/PaymentMethodScreen': (context) => PaymentMethodScreen(),
        '/RestaurantsProfileScreen': (context) => RestaurantsProfileScreen(context: context),
        '/CollectTomorrowScreen': (context) => CollectTomorrowScreen(),
        '/PreviousOrderScreen': (context) => PreviousOrderScreen(),
        '/SearchResultScreen': (context) => SearchResultScreen(context: context),
        '/SearchScreen': (context) => SearchScreen(),
      },
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: btnbgColor),
          useMaterial3: true,

          fontFamily: "Mont"),
      // home: AppRoot(),
    ),
  );
}
