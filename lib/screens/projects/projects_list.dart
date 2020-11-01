import 'package:flutter/material.dart';
import 'package:housing/screens/data.dart';
import 'package:housing/screens/detail_page.dart';
import 'package:housing/screens/home_page.dart';
import 'package:housing/widgets/hot_deal_card.dart';
import './project_detail.dart';

class Hotels_List extends StatefulWidget {
  @override
  _Hotels_ListState createState() => _Hotels_ListState();
}

class _Hotels_ListState extends State<Hotels_List> {
  List<Property> properties = getPropertyList();
  var _trendingList;
  var _featuredList;
  List<Widget> buildProperties() {
    List<Widget> list = [];
    for (var i = 0; i < properties.length; i++) {
      list.add(Hero(
          tag: properties[i].frontImage,
          child: buildProperty(properties[i], i)));
    }
    return list;
  }

  Widget buildProperty(Property property, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(property: property)),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 24),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(
          height: 210,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(property.frontImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 1.0],
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  width: 80,
                  padding: EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  child: Center(
                    child: Text(
                      "FOR " + property.label,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          property.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          r"₹" + property.price,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              property.location,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.zoom_out_map,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              property.sqm + " sq/m",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                              size: 14,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              property.review + " Reviews",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    var list = HomePage.featuredDeals.list;
    _trendingList = list.where((element) => element.expiry == null).toList();
    _featuredList = list.where((element) => element.expiry != null).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: headerWidget(),
                ),
                Positioned(
                  bottom: 0,
                  right: 40,
                  left: 40,
                  child: Container(
                    child: Material(
                      borderRadius: BorderRadius.circular(25),
                      elevation: 7,
                      child: TextField(
                        onChanged: (text) {},
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search",
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * .8,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Featured Properties",
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/properties');
                    },
                    child: Text("See all",
                        style: TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 4.25,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 15),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return buildProperties()[index];
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Cities", style: TextStyle(fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 12,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 15),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return listViewItemCities(index);
                  },
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Trending Projects",
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  Text("See all",
                      style: TextStyle(
                          color: Colors.pink, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 4.25,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 15),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _trendingList.length,
                  itemBuilder: (context, index) {
                    final item = _trendingList[index];
                    return deal_card(
                      propertyTitle: item.propertyTitle,
                      location: item.location,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Invest with HomePlanify",
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  Text("See all",
                      style: TextStyle(
                          color: Colors.pink, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 4.25,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 15),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _featuredList.length,
                  itemBuilder: (context, index) {
                    final item = _featuredList[index];
                    return listViewItemRecommend(index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  headerWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://thumbnails.trvl-media.com/T13T6Xjd9VcTdlOIevad6mqpj7I=/773x530/smart/filters:quality(60)/images.trvl-media.com/hotels/33000000/32670000/32661200/32661112/f0212e0c_z.jpg"),
              fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "HomePlanify",
            style: TextStyle(
                letterSpacing: 2.0,
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  List<Color> colors = [
    Color(0xFF7FBC6E),
    Color(0xFFC1E7E8),
    Color(0xFFFD4867),
    Color(0xFF8E8CD8)
  ];
  List<String> cities = ["Gurgaon", "Faridabad", "Sonipat", "Karnal"];

  listViewItemCities(int index) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.25,
      height: MediaQuery.of(context).size.height / 12,
      decoration: BoxDecoration(
        color: colors[index],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 7),
          Text(
            cities[index],
            style: TextStyle(
                fontSize: 20,
                letterSpacing: 1.5,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  listViewItemRecommend(int index) {
    return GestureDetector(
      onTap: () {
//        Navigator.push(context, MaterialPageRoute(builder: (context) {
//          return HotelDetail(
//            hotel: recommendList[index],
//          );
//        }));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.65,
        height: MediaQuery.of(context).size.height / 6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(
                    'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/home-decor-ideas-sfshowcaselivingroom-03-1585257771.jpg?crop=0.654xw:1.00xh;0.125xw,0&resize=640:*'),
                fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    _featuredList[index].propertyTitle,
                    style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Text(
                      _featuredList[index].location,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
