import 'package:flutter/material.dart';
import 'package:housing/Project_card.dart';
import 'package:housing/bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housing/hot_deal_card.dart';

class home_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(bottom: 90.0),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.6), BlendMode.dstATop),
                        image: NetworkImage(
                          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                        ),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.near_me,
                                size: 30.0,
                                color: Colors.blueGrey,
                              ),
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                                size: 30.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          'Housing App',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Locality,landmark...',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            suffixIcon: GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black54,
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 25.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                                child: Text("BUY"),
                                color: Colors.amberAccent,
                                textColor: Colors.white,
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                            RaisedButton(
                                child: Text("SELL"),
                                color: Colors.amberAccent,
                                textColor: Colors.white,
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                            RaisedButton(
                                child: Text("RENT"),
                                color: Colors.amberAccent,
                                textColor: Colors.white,
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 5.0,
                  color: Colors.grey,
                  thickness: 3.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text(
                    'Hot Deals 🔥',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 250.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      deal_card(),
                      deal_card(),
                      deal_card(),
                    ],
                  ),
                ),
                Divider(
                  height: 5.0,
                  color: Colors.grey[200],
                  thickness: 3.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text(
                    'Trending Projects',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 250.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      TrendingProjectsCard(),
                      TrendingProjectsCard(),
                      TrendingProjectsCard(),
                    ],
                  ),
                ),
                Divider(
                  height: 5.0,
                  color: Colors.grey[200],
                  thickness: 3.0,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottom_bar(0),
    );
  }
}
