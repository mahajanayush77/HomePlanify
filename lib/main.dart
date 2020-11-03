import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housing/constant.dart';
import 'package:housing/screens/add_property.dart';
import 'package:housing/screens/home/featured_projects.dart';
import 'package:housing/screens/home/invest_properties.dart';
import 'package:housing/screens/profile/bookmarks.dart';
import 'package:housing/screens/profile/my_properties.dart';
import 'package:housing/screens/home/home_page.dart';
import 'package:housing/screens/news_page.dart';
import 'package:housing/screens/onboarding/Login/login_screen.dart';
import 'package:housing/screens/onboarding/Signup/signup_screen.dart';
import 'package:housing/screens/onboarding/Welcome/welcome_screen.dart';
import 'package:housing/screens/profile/menu_options_screen.dart';

import './utilities/auth_helper.dart';
// import 'screens/projects/home_page.dart';
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
        '/': (context) => HomePage(),
        '/home': (context) => HomePage(),
        '/welcome': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/properties': (context) => Search(),
        '/invest_properties': (context) => InvestProperties(),
        '/featured_projects': (context) => FeaturedProjects(),
        '/news': (context) => news_page(),
        '/add_property': (context) => AddProperty(),
        '/profile': (context) => MenuOptionsScreen(),
        '/bookmarks': (context) => Bookmarks(),
        '/my_properties': (context) => MyProperties(),
      },
    );
  }
}
