import 'package:flutter/material.dart';
import './projects_list.dart';
import '../../widgets/bottom_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HotelsList(),
      ),
      bottomNavigationBar: bottom_bar(0),
    );
  }
}
