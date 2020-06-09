import 'package:flutter/material.dart';
import 'package:housing/bottom_bar.dart';

class news_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        backgroundColor: Colors.amber,
      ),
      bottomNavigationBar: bottom_bar(1),
    );
  }
}
