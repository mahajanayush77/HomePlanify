import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Provider
import '../../provider/properties.dart';
// Routes
import '../../screens/home/property_detail.dart';
import '../../screens/splash_screen.dart';
import '../../screens/webview.dart';
// Utilities
import '../../utilities/api-response.dart';
import '../../utilities/api_endpoints.dart';
import '../../utilities/api_helper.dart';
// Widgets
import '../../widgets/hot_deal_card.dart';
import '../../widgets/search_widget.dart';

class HotelsList extends StatefulWidget {
  @override
  _HotelsListState createState() => _HotelsListState();
}

class _HotelsListState extends State<HotelsList> {
  // Initialise Api Response object for GET
  Future<ApiResponse> _properties;
  Future<ApiResponse> featuredProperties;
  Future<ApiResponse> investProperties;

  @override
  // Init State of the Widget
  // Executes before the whole Widget is built
  void initState() {
    // calling various GET requests
    _properties = ApiHelper().getWithoutAuthRequest(
      endpoint: eProperties,
      query: {
        'visible': 'true',
        'verified': 'true',
      },
    );
    featuredProperties = ApiHelper().getWithoutAuthRequest(
      endpoint: eFeaturedProperties,
    );
    investProperties = ApiHelper().getWithoutAuthRequest(
      endpoint: eInvestProperties,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // Called to monitor change in provider of Properties
    final proper = Provider.of<Properties>(context);
    proper.fetchAllProperties();
    super.didChangeDependencies();
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
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: SearchProperties(),
                          );
                        },
                        onChanged: (text) {
                          print(text);
                        },
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
                  Text("Properties",
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
                child: FutureBuilder(
                  future: _properties,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 15),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.data.length < 4
                            ? snapshot.data.data.length
                            : 4,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> property =
                              snapshot.data.data.toList()[index];
                          print(property);
                          return GestureDetector(
                              onTap: () {
                                print(index);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Detail(id: property['id'])));
                              },
                              child: Prop(
                                id: property['id'],
                                type: property['type'],
                                property_name: property['property_name'],
                                city: property['city'].split(" ")[0],
                                construction_status:
                                    property['construction_status'],
                                available_from: property['available_from'],
                                bedrooms: property['bedrooms'],
                                total_price: property['total_price'],
                                views: property['views'],
                                main_image: property['main_image'],
                              ));
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return SplashScreen();
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
                  Text("Featured Projects",
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/featured_projects');
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
                child: FutureBuilder(
                  future: featuredProperties,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 15),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.data.length < 4
                            ? snapshot.data.data.length
                            : 4,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> item =
                              snapshot.data.data.toList()[index];
                          print(item);
                          return deal_card(
                            propertyTitle: item['name'],
                            location: item['location'],
                            image: item['image'],
                            link: item['link'],
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return SplashScreen();
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/invest_properties');
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
                child: FutureBuilder(
                  future: investProperties,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 15),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.data.length < 4
                            ? snapshot.data.data.length
                            : 4,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> item =
                              snapshot.data.data.toList()[index];
                          print(item);
                          return InvestProp(
                            title: item['title'],
                            image: item['image'],
                            link: item['link'],
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return SplashScreen();
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
            "Home Planify",
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
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, '/properties', arguments: cities[index]);
        },
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
      ),
    );
  }
}

class InvestProp extends StatelessWidget {
  String title;
  String image;
  String link;
  InvestProp({this.title, this.image, this.link});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.65,
      height: MediaQuery.of(context).size.height / 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(
                image,
              ),
              fit: BoxFit.fill)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    title,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            if (link != null)
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  size: 24,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WebScreen(
                      url: link,
                    ),
                  ));
                },
              ),
          ],
        ),
      ),
    );
  }
}

class Prop extends StatelessWidget {
  int id;
  String type;
  String property_name;
  String city;
  String construction_status;
  String available_from;
  int bedrooms;
  int total_price;
  int views;
  String main_image;

  Prop({
    this.id,
    this.main_image,
    this.city,
    this.construction_status,
    this.total_price,
    this.property_name,
    this.views,
    this.type,
    this.available_from,
    this.bedrooms,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
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
            image: NetworkImage(
              main_image,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
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
                    type == 'S' ? "FOR SALE" : "FOR RENT",
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
                        property_name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " Rs " + total_price.toString(),
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
                            city.substring(0),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.hotel,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            bedrooms.toString(),
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
                            Icons.remove_red_eye,
                            color: Colors.yellow[700],
                            size: 14,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            views.toString() + " Views",
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
    );
  }
}
