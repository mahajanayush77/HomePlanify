import 'package:flutter/material.dart';

class Option {
  Icon icon;
  String title;
  String gestureLink;
  Option({this.icon, this.title, this.gestureLink});
}

final options = [
  Option(
    icon: Icon(Icons.account_circle, size: 40.0),
    title: 'Profile',
    gestureLink: '/account_profile',
  ),
  Option(
    icon: Icon(Icons.all_inbox_rounded, size: 40.0),
    title: 'My Properties',
    gestureLink: '/my_properties',
  ),
  Option(
    icon: Icon(Icons.bookmarks_rounded, size: 40.0),
    title: 'Bookmarked Properties',
    gestureLink: '/bookmarks',
  ),
  Option(
    icon: Icon(Icons.chat_rounded, size: 40.0),
    title: 'Contact Us',
    gestureLink: '/contactUs',
  ),

  Option(
    icon: Icon(Icons.lock_rounded, size: 40.0),
    title: 'Change Passsword',
    gestureLink: '/change_password',
  ),

];
