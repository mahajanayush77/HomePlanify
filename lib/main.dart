import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housing/news_page.dart';
import 'package:housing/profile_page.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.amber,
        accentColor: Colors.amberAccent,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => home_page(),
        '/news': (context) => news_page(),
        '/profile': (context) => profile_page(),
      },
    );
  }
}

//BottomNavigationBar(
//type: BottomNavigationBarType.fixed,
//items: <BottomNavigationBarItem>[
//BottomNavigationBarItem(
//icon: Icon(Icons.search),
//title: Text('Search'),
//),
//BottomNavigationBarItem(
//icon: Icon(Icons.payment),
//title: Text('Pay Rent'),
//),
//BottomNavigationBarItem(
//icon: Icon(Icons.message),
//title: Text('News'),
//),
//BottomNavigationBarItem(
//icon: Icon(Icons.supervised_user_circle),
//title: Text('Profile'),
//),
//],
//currentIndex: 0,
//);
