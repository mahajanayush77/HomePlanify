import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrendingProjectsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //navigate to project description
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        width: 250.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey[200],
        ),
        child: Card(
          elevation: 10.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Image(
                  image: NetworkImage(
                      'https://img.etimg.com/photo/msid-66350155/untitled-19.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 5.0),
                child: Text(
                  'Rs. 10 - 12 Cr.',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.w800,
                    fontSize: 22.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  bottom: 2.5,
                ),
                child: Text(
                  'DLF FarmGreens',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  bottom: 2.5,
                ),
                child: Text(
                  'DLF Communities',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  bottom: 2.5,
                ),
                child: Text(
                  'Gurgaon,Haryana',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.w300,
                    fontSize: 13.0,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
