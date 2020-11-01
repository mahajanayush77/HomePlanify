import 'package:flutter/material.dart';
import 'package:housing/screens/projects/projects_list.dart';
import 'package:housing/screens/splash_screen.dart';
import 'package:housing/utilities/api-response.dart';
import 'package:housing/utilities/api_endpoints.dart';
import 'package:housing/utilities/api_helper.dart';
import './data.dart';
import './filter.dart';
import './detail_page.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Property> properties = getPropertyList();
  Future<ApiResponse> _properties;
  @override
  void initState() {
    // TODO: implement initState
    _properties = ApiHelper().getWithoutAuthRequest(
      endpoint: eProperties,
      query: {
        'visible': 'true',
        'verified': 'true',
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Properties'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
//          Padding(
//            padding: EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 16),
//            child: TextField(
//              style: TextStyle(
//                fontSize: 28,
//                height: 1,
//                color: Colors.black,
//                fontWeight: FontWeight.bold,
//              ),
//              decoration: InputDecoration(
//                hintText: 'Search',
//                hintStyle: TextStyle(
//                  fontSize: 28,
//                  color: Colors.grey[400],
//                ),
//                enabledBorder: UnderlineInputBorder(
//                  borderSide: BorderSide(color: Colors.grey[400]),
//                ),
//                focusedBorder: UnderlineInputBorder(
//                  borderSide: BorderSide(color: Colors.grey[400]),
//                ),
//                border: UnderlineInputBorder(
//                  borderSide: BorderSide(color: Colors.grey[400]),
//                ),
//                suffixIcon: Padding(
//                  padding: EdgeInsets.only(left: 16),
//                  child: Icon(
//                    Icons.search,
//                    color: Colors.grey[400],
//                    size: 28,
//                  ),
//                ),
//              ),
//            ),
//          ),
//          Padding(
//            padding: EdgeInsets.only(top: 16),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: [
//                Expanded(
//                  child: Container(
//                    height: 32,
//                    child: Stack(
//                      children: [
//                        ListView(
//                          physics: BouncingScrollPhysics(),
//                          scrollDirection: Axis.horizontal,
//                          children: [
//                            SizedBox(
//                              width: 24,
//                            ),
//                            buildFilter("House"),
//                            buildFilter("Price"),
//                            buildFilter("Security"),
//                            buildFilter("Bedrooms"),
//                            buildFilter("Garage"),
//                            buildFilter("Swimming Pool"),
//                            SizedBox(
//                              width: 8,
//                            ),
//                          ],
//                        ),
//                        Align(
//                          alignment: Alignment.centerRight,
//                          child: Container(
//                            width: 28,
//                            decoration: BoxDecoration(
//                              gradient: LinearGradient(
//                                begin: Alignment.centerRight,
//                                end: Alignment.centerLeft,
//                                stops: [0.0, 1.0],
//                                colors: [
//                                  Theme.of(context).scaffoldBackgroundColor,
//                                  Theme.of(context)
//                                      .scaffoldBackgroundColor
//                                      .withOpacity(0.0),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//                GestureDetector(
//                  onTap: () {
//                    _showBottomSheet();
//                  },
//                  child: Padding(
//                    padding: EdgeInsets.only(left: 16, right: 24),
//                    child: Text(
//                      "Filters",
//                      style: TextStyle(
//                        fontSize: 18,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: FutureBuilder(
                future: _properties,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 15),
                      shrinkWrap: true,
                      itemCount: snapshot.data.data.length < 4
                          ? snapshot.data.data.length
                          : 4,
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> property =
                            snapshot.data.data.toList()[index];
                        print(property);
                        return Prop(
                          id: property['id'],
                          type: property['type'],
                          property_name: property['property_name'],
                          city: property['city'].split(" ")[0],
                          construction_status: property['construction_status'],
                          available_from: property['available_from'],
                          price_sq: property['price_sq'],
                          total_price: property['total_price'],
                          views: property['views'],
                          main_image: property['main_image'],
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

  Widget buildFilter(String filterName) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(
            color: Colors.grey[300],
            width: 1,
          )),
      child: Center(
        child: Text(
          filterName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
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
        });
  }
}
