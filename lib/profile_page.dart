import 'package:flutter/material.dart';
import 'package:housing/bottom_bar.dart';

class profile_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.amber,
      ),
      bottomNavigationBar: bottom_bar(2),
    );
  }
}
