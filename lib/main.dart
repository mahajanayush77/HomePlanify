import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housing/constant.dart';
import 'package:housing/screens/news_page.dart';
import 'package:housing/screens/profile_page.dart';
import 'screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: kPrimaryBackgroundColor,
        accentColor: kAccentBackgroundColor,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/news': (context) => news_page(),
        '/profile': (context) => profile_page(),
      },
    );
  }
}
