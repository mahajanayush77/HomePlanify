import 'package:flutter/material.dart';
import 'package:housing/constant.dart';
import 'package:housing/widgets/bottom_bar.dart';

class profile_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: kPrimaryBackgroundColor,
      ),
      bottomNavigationBar: bottom_bar(3),
    );
  }
}
