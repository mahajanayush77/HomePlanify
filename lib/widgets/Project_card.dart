import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housing/screens/home/property_detail.dart';
import '../constant.dart';

class TrendingProjectsCard extends StatelessWidget {
  final String price;
  final String propertyTitle;
  final String company;
  final String location;
  final Image image;
  TrendingProjectsCard({
    this.location,
    this.company,
    this.price,
    this.propertyTitle,
    this.image = null,
  });
  @override
  Widget build(BuildContext context) {
    final size = DeviceSize(context: context);
    return GestureDetector(
      onTap: () {
        //navigate to project description
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Detail()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        width: size.width * 0.63,
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
                  'Rs. ' + price,
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
                  '$propertyTitle',
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
                  '$company',
                  softWrap: true,
                  overflow: TextOverflow.fade,
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
                  '$location',
                  softWrap: true,
                  overflow: TextOverflow.fade,
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
