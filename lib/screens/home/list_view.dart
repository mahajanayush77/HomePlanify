import 'package:flutter/material.dart';
import 'package:housing/models/property.dart';
import 'package:housing/screens/home/property_detail.dart';
import 'package:housing/screens/splash_screen.dart';

import './filter.dart';
import 'package:provider/provider.dart';
import 'package:housing/provider/properties.dart' as prop;
import 'package:housing/provider/filter.dart' as filter;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String search = '';
  String type = "R";
  int bedrooms = 2;
  int bathrooms = null;
  int rooms = null;
  String construction_status = null;
  int price_start = null;
  int price_end = null;
  bool featured = false;
  List features = null;
  String orderby = null;
  Map<String, String> query;

  @override
  void initState() {
    super.initState();
  }

  // void updateproperties()

  @override
  Widget build(BuildContext context) {
    search = ModalRoute.of(context).settings.arguments;
    final proper = Provider.of<prop.Properties>(context);
    final filterquery = Provider.of<filter.Filter>(context);

    void filterProperties(String value) {
      filterquery.updateSearch(value);
      query = filterquery.toQuery();
      print(query);
      setState(() {});
      // proper.fetchProperties(query);
    }

    filterProperties(search);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 38, left: 24, right: 2, bottom: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: search,
                    onEditingComplete: () {
                      filterProperties(search);
                    },
                    onChanged: (value) {
                      filterProperties(value);
                    },
                    style: TextStyle(
                      fontSize: 20,
                      height: 1,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search Name, City, Area',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[400],
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[600]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[600]),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[600]),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey[600],
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      "Filters",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: FutureBuilder(
                future: proper
                    .fetchAllProperties(query)
                    .whenComplete(() => print('hello')),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 15),
                      shrinkWrap: true,
                      itemCount: proper.properties.length,
                      itemBuilder: (context, index) {
                        final property = proper.properties;
                        return ChangeNotifierProvider.value(
                          value: property[index],
                          child: Prop(),
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
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Filter(),
            ],
          );
        }).then((value) {
      final filterquery = Provider.of<filter.Filter>(context, listen: false);

      setState(() {
        query = filterquery.toQuery();
      });
    });
  }
}

class Prop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final proper = Provider.of<prop.Properties>(context, listen: false);
    final property = Provider.of<Property>(context);

    return GestureDetector(
      onTap: () {
        // print(index);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Detail(id: property.id)));
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                property.main_image,
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
                      property.type == 'S' ? "FOR SALE" : "FOR RENT",
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
                          property.property_name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " Rs " + property.total_price.toString(),
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
                              property.city.substring(0),
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
                              property.bedrooms.toString(),
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
                              property.views.toString() + " Views",
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
}
