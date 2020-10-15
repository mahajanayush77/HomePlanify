import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housing/constant.dart';
import 'package:housing/screens/news_page.dart';
import 'package:housing/screens/onboarding/Login/login_screen.dart';
import 'package:housing/screens/onboarding/Signup/signup_screen.dart';
import 'package:housing/screens/onboarding/Welcome/welcome_screen.dart';
import 'package:housing/screens/profile_page.dart';
import 'screens/home_page.dart';
import 'screens/list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: kPrimaryBackgroundColor,
        accentColor: kAccentBackgroundColor,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/properties': (context) => Search(),
        '/news': (context) => news_page(),
        '/add_property': (context) => news_page(),
        '/profile': (context) => profile_page(),
      },
    );
  }
}
