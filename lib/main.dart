import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housing/constant.dart';
import 'package:housing/screens/add_property.dart';
import 'package:housing/screens/news_page.dart';
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
      theme: ThemeData(
        primarySwatch: kPrimaryBackgroundColor,
        accentColor: kAccentBackgroundColor,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/properties': (context) => Search(),
        '/news': (context) => news_page(),
        '/add_property': (context) => AddProperty(),
        '/profile': (context) => profile_page(),
      },
    );
  }
}
