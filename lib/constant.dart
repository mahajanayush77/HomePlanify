import 'package:flutter/material.dart';

// Colors
const kPrimaryColor = Colors.amber; // Primary Color of Material App
const kPrimaryLightColor = Color(0xFFFFF8E1); // Primary Light Color
const Color kPrimaryBackgroundColor = Colors.amber; // Primary Background Color
const Color kAccentBackgroundColor =
    Colors.amberAccent; // Accent Background Color

// Text Styles
final TextStyle kButtonText = TextStyle(
  fontSize: 16.0,
);
final TextStyle kLinkText = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Colors.indigo,
);
final TextStyle kShadedTitle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: Colors.grey.shade600,
);
final TextStyle kMessageStyle = kShadedTitle.copyWith();
final TextStyle kCorrectMessageStyle = kMessageStyle.copyWith(
  color: Colors.green,
);
final TextStyle kIncorrectMessageStyle = kMessageStyle.copyWith(
  color: Colors.red,
);

// Device Size Class ; manages the size of widgets for various screen sizes
class DeviceSize {
  double height;
  double width;
  BuildContext context;
  DeviceSize({this.context}) {
    final size = MediaQuery.of(context).size;
    height = size.height - kBottomNavigationBarHeight;
    width = size.width;
  }
}
