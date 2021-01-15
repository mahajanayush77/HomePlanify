import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housing/models/property.dart';
import 'package:housing/provider/bookmarks.dart' as prop;
import 'package:housing/screens/home/property_detail.dart';

import 'package:housing/screens/splash_screen.dart';
import 'package:housing/utilities/api-response.dart';
import 'package:housing/utilities/api_endpoints.dart';
import 'package:housing/utilities/api_helper.dart';
import '../data.dart';
import '../filter.dart';
import 'package:provider/provider.dart';

class Bookmarks extends StatefulWidget {
  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {

  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final proper = Provider.of<prop.Bookmarks>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child:FutureBuilder(
                  future: proper.fetchProducts(),
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      return ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(width: 15),
                        shrinkWrap: true,
                        itemCount: proper.myProp.length,
                        itemBuilder: (context, index){
                          final property = proper.myProp;
                          print(property);
                          return ChangeNotifierProvider.value(
                            value: property[index],
                            child: Prop(),
                          );
                        },
                      );
                    } else if (snapshot.hasError){
                      return Text("error: ${snapshot.error}");
                    }
                    return SplashScreen();
                  },
                )
            ),
          )
        ],
      ),
    );
  }
}




class Prop extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final proper = Provider.of<prop.Bookmarks>(context, listen: false);
    final property = Provider.of<Property>(context);

    return GestureDetector(
        onTap: () {
      // print(index);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Detail(id: property.id)));
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
                flex: 2,
                child: Column(
                  children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => proper.removefrombookmarks(property.id),
                      ),
                      ],
                    )
                  ],
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
