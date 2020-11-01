import 'package:flutter/material.dart';

class Option {
  Icon icon;
  String title;
  String subtitle;

  Option({this.icon, this.title, this.subtitle});
}

final options = [
  Option(
    icon: Icon(Icons.account_circle, size: 40.0),
    title: 'Profile',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: Icon(Icons.all_inbox_rounded, size: 40.0),
    title: 'My Properties',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: Icon(Icons.bookmarks_rounded, size: 40.0),
    title: 'Bookmarked Properties',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: Icon(Icons.chat_rounded, size: 40.0),
    title: 'Contact Us',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: Icon(Icons.wysiwyg_rounded, size: 40.0),
    title: 'F.A.Q.',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: Icon(Icons.lock_rounded, size: 40.0),
    title: 'Change Passsword',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: Icon(Icons.logout, size: 40.0),
    title: 'Log Out',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
];
