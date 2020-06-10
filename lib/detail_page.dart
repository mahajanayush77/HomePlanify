import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final double bottomSheetCornerRadius = 50;

  @override
  Widget build(BuildContext context) {
    final coverImageHeightCalc =
        MediaQuery.of(context).size.height / 2 + bottomSheetCornerRadius;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(),
          Hero(
            tag: 'heart1',
            child: Container(
              height: coverImageHeightCalc,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  child: PageIndicatorContainer(
                    align: IndicatorAlign.bottom,
                    length: 3,
                    indicatorSpace: 12.0,
                    padding: EdgeInsets.only(bottom: 60),
                    indicatorColor: Colors.blueGrey,
                    indicatorSelectorColor: Colors.white,
                    shape: IndicatorShape.circle(size: 8),
                    child: PageView(
                      children: <Widget>[
                        Image.network(
                          'https://img.etimg.com/photo/msid-66350155/untitled-19.jpg',
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          'https://img.etimg.com/photo/msid-66350155/untitled-19.jpg',
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          'https://img.etimg.com/photo/msid-66350155/untitled-19.jpg',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
