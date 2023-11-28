import 'package:flutter/material.dart';
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
       // '/Log_in': (context) =>const LoginScreen(),
      },
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: secondaryColor),
          useMaterial3: true,
          fontFamily: "Poppins"),
      // home: AppRoot(),
    ),
  );
}
