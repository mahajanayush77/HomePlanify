import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class deal_card extends StatelessWidget {
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
                    'Rs. 50 - 80 L',
                    style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.w900,
                      fontSize: 25.0,
                    ),
                  ),
                  Text(
                    'Expires in 2 days',
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
                    'DLF FarmGreens',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                    ),
                  ),
                  MaterialButton(
                    elevation: 0,
                    textColor: Colors.white,
                    color: Colors.amber.shade300,
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
                  Text(
                    'DLF Communities',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    'Sector 10, Gurgaon, Haryana',
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
