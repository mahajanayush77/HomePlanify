import 'package:flutter/material.dart';

class Option {
  Icon icon;
  String title;
  String subtitle;

  Option({this.icon, this.title, this.subtitle});
}

final options = [
  Option(
    icon: Icon(Icons.dashboard, size: 40.0),
    title: 'Profile',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: Icon(Icons.do_not_disturb, size: 40.0),
    title: 'My Properties',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: Icon(Icons.account_circle, size: 40.0),
    title: 'Bookmarked Properties',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: Icon(Icons.invert_colors, size: 40.0),
    title: 'Contact Us',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: Icon(Icons.watch_later, size: 40.0),
    title: 'F.A.Q.',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: Icon(Icons.fastfood, size: 40.0),
    title: 'Change Passsword',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: Icon(Icons.local_airport, size: 40.0),
    title: 'Log Out',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
];
