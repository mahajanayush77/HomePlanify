import 'package:flutter/material.dart';

class deal_card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        color: Colors.blueGrey,
        child: Container(
          child: Center(
              child: Text(
            'HI',
            style: TextStyle(color: Colors.white, fontSize: 36.0),
          )),
        ),
      ),
    );
  }
}
