import 'package:flutter/material.dart';

class Option {
  Icon icon;
  String title;
  String subtitle;
  String gesturelink;
  Option({this.icon, this.title, this.subtitle, this.gesturelink});
}

final options = [
  Option(
    icon: Icon(Icons.account_circle, size: 40.0),
    title: 'Profile',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
    gesturelink: '/account_profile',
  ),
  Option(
    icon: Icon(Icons.all_inbox_rounded, size: 40.0),
    title: 'My Properties',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
    gesturelink: '/my_properties',
  ),
  Option(
    icon: Icon(Icons.bookmarks_rounded, size: 40.0),
    title: 'Bookmarked Properties',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
    gesturelink: '/bookmarks',
  ),
  Option(
    icon: Icon(Icons.chat_rounded, size: 40.0),
    title: 'Contact Us',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
    gesturelink: '/contact_us',
  ),
  Option(
    icon: Icon(Icons.wysiwyg_rounded, size: 40.0),
    title: 'F.A.Q.',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
    gesturelink: '/faq',
  ),
  Option(
    icon: Icon(Icons.lock_rounded, size: 40.0),
    title: 'Change Passsword',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
    gesturelink: '/change_password',
  ),
  Option(
    icon: Icon(Icons.logout, size: 40.0),
    title: 'Log Out',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
    gesturelink: '/logout',
  ),
];
