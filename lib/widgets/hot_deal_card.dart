import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class deal_card extends StatelessWidget {
  final String propertyTitle;
  final String location;
  final Image image;
  deal_card({this.location, this.propertyTitle, this.image = null});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Card(
        color: Colors.grey[200],
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Image(
                image: NetworkImage(
                  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/home-decor-ideas-sfshowcaselivingroom-03-1585257771.jpg?crop=0.654xw:1.00xh;0.125xw,0&resize=640:*',
                ),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '$propertyTitle',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 2.5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '$location',
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
