import 'package:flutter/material.dart';
import 'package:housing/constant.dart';
import 'package:housing/widgets/Project_card.dart';
import 'package:housing/widgets/bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housing/widgets/hot_deal_card.dart';
import '../provider/featuredDeals.dart';

class HomePage extends StatefulWidget {
  static FeaturedDeals featuredDeals = FeaturedDeals();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _featuredList;
  var _trendingList;
  @override
  void initState() {
    var list = HomePage.featuredDeals.list;
    _trendingList = list.where((element) => element.expiry == null).toList();
    _featuredList = list.where((element) => element.expiry != null).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = DeviceSize(context: context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(bottom: size.height * 0.05),
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
                          'HomePlanify',
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
                                color: kPrimaryBackgroundColor,
                                textColor: Colors.white,
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                            RaisedButton(
                                child: Text("SELL"),
                                color: kPrimaryBackgroundColor,
                                textColor: Colors.white,
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                            RaisedButton(
                                child: Text("RENT"),
                                color: kPrimaryBackgroundColor,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Featured Deals',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          'View All',
                          style: GoogleFonts.aBeeZee(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: size.height * 0.35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _featuredList.length,
                    itemBuilder: (context, index) {
                      final item = _featuredList[index];
                      return deal_card(
                        propertyTitle: item.propertyTitle,
                        location: item.location,
                      );
                    },
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Trending Projects',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          'View All',
                          style: GoogleFonts.aBeeZee(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 250.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _trendingList.length,
                    itemBuilder: (context, index) {
                      final item = _trendingList[index];
                      return TrendingProjectsCard(
                        propertyTitle: item.propertyTitle,
                        price: item.price,
                        company: item.company,
                        location: item.location,
                      );
                    },
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
