import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/pages/bottomnav/bottomnav_page.dart';
import 'package:mini_project_flutter_alterra/pages/splash/splash_page.dart';
import 'package:mini_project_flutter_alterra/pages/splash/started_page.dart';
import 'package:mini_project_flutter_alterra/providers/contact_provider.dart';
import 'package:mini_project_flutter_alterra/providers/database_provider.dart';
import 'package:mini_project_flutter_alterra/providers/restaurant_provider.dart';
import 'package:mini_project_flutter_alterra/providers/theme_provider.dart';
import 'package:mini_project_flutter_alterra/styles/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DatabaseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: mainColor,
        ),
        routes: {
          '/': (context) => const SplashPage(),
          '/started': (context) => const GetStartedPage(),
          '/home': (context) => const BottomnavPage(),
        },
      ),
    );
  }
}
