import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housing/constant.dart';

class deal_card extends StatelessWidget {
  final String price;
  final String propertyTitle;
  final String company;
  final String location;
  final Image image;
  final int expiry;
  deal_card(
      {this.company,
      this.location,
      this.price,
      this.propertyTitle,
      this.expiry,
      this.image = null});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: MediaQuery.of(context).size.width * 0.85,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Rs. ' + price,
                    style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.w900,
                      fontSize: 25.0,
                    ),
                  ),
                  Text(
                    'Expires in ' + '$expiry' + ' days',
                    style: GoogleFonts.voltaire(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: Colors.red[400],
                    ),
                  ),
                ],
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
                  MaterialButton(
                    elevation: 0,
                    textColor: Colors.white,
                    color: kPrimaryBackgroundColor,
                    height: 0,
                    child: Row(
                      children: <Widget>[
                        Text('Book Now'),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                    minWidth: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 2.0),
                    onPressed: () {},
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
                  Expanded(
                    child: Text(
                      '$company',
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
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
