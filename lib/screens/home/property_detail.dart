import 'package:flutter/material.dart';
import '../data.dart';
import 'package:housing/models/property.dart';
import 'package:housing/screens/splash_screen.dart';
import 'package:housing/utilities/api-response.dart';
import 'package:housing/utilities/api_endpoints.dart';
import 'package:housing/utilities/api_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatefulWidget {
  int id;
  Detail({this.id});

  @override
  _DetailState createState() => _DetailState(id: id);
}

class _DetailState extends State<Detail> {
  int id;
  _DetailState({this.id});

  Future<ApiResponse> response;
  Property property2;
  String endpointsingle;

  @override
  void initState() {
    // TODO: implement initState
    endpointsingle = eProperties + id.toString() + "/";
    response = ApiHelper().getWithoutAuthRequest(
      endpoint: endpointsingle,
    );
    super.initState();
  }

  Property2 property = Property2(
    "RENT",
    "Salu House",
    "3,500.00",
    "Miami",
    "3,300",
    "4.6",
    "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
    "assets/images/house_04.jpg",
    "assets/images/owner.jpg",
    [
      "assets/images/kitchen.jpg",
      "assets/images/bath_room.jpg",
      "assets/images/swimming_pool.jpg",
      "assets/images/bed_room.jpg",
      "assets/images/living_room.jpg",
    ],
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: FutureBuilder(
      future: response,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          property2 = Property.fromJson(snapshot.data.data);
          print("Single Property");
          print(property);
          print(snapshot.data.data);
          return Stack(
            children: [
              Hero(
                tag: property2.main_image,
                child: Container(
                  height: size.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(property2.main_image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // child: Container(
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topCenter,
                  //       end: Alignment.bottomCenter,
                  //       colors: [
                  //         const Color(0xffee0000),
                  //         const Color(0xffeeee00)
                  //       ], // red to yellow
                  //       // List: [
                  //       //   Colors.transparent,
                  //       //   Colors.black.withOpacity(0.7),
                  //       // ],
                  //     ),
                  //   ),
                  // ),
                ),
              ),
              Container(
                height: size.height * 0.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),

                          // Icon(
                          //   Icons.notifications_none,
                          //   color: Colors.white,
                          //   size: 28,
                          // ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Container(
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
                            "FOR " + property2.type == 'S' ? "FOR SALE" : "FOR RENT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            property2.property_name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.bookmark,
                                color: Colors.yellow[700],
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 8,
                        bottom: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                property2.city,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                property2.views.toString() + " Views",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              DraggableScrollableSheet(
                initialChildSize: 0.65,
                minChildSize:0.65,
                builder: (context, scrollController){
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      height: size.height * 0.65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 65,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(property.ownerImage),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Kunal Sharma",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "Agent",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color:
                                          Colors.yellow[700].withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(Icons.phone),
                                            color: Colors.yellow[700],
                                            iconSize: 20,
                                            onPressed: () =>
                                                launch("tel://9999998627"),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color:
                                          Colors.yellow[700].withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.message,
                                            color: Colors.yellow[700],
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 24,
                                left: 24,
                                bottom: 24,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  buildFeature(Icons.hotel,
                                      property2.bedrooms.toString() + " Bedroom"),
                                  buildFeature(Icons.wc,
                                      property2.bathrooms.toString() + " Bathroom"),
                                  buildFeature(Icons.kitchen,
                                      property2.rooms.toString() + " Room"),
                                  buildFeature(Icons.local_parking,
                                      property2.construction_status.toString()),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 24,
                                left: 24,
                                bottom: 16,
                              ),
                              child: Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 24,
                                left: 24,
                                bottom: 24,
                              ),
                              child: Text(
                                property2.additional_features,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                right: 24,
                                left: 24,
                                bottom: 16,
                              ),
                              child: Text(
                                "Photos",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: 24,
                                ),
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: buildPhotos(property.images),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 24,
                                left: 24,
                                bottom: 16,
                              ),
                              child: Text(
                                "Features",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 24,
                                left: 24,
                                bottom: 16,
                              ),
                              child: Column(
                                children: [

                                  ListTile(
                                    leading: Icon(Icons.check),
                                    title: Text('Parking'),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return SplashScreen();
      },
    ));
  }

  Widget buildFeature(IconData iconData, String text) {
    return Column(
      children: [
        Icon(
          iconData,
          color: Colors.yellow[700],
          size: 28,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  List<Widget> buildPhotos(List<String> images) {
    List<Widget> list = [];
    list.add(SizedBox(
      width: 24,
    ));
    for (var i = 0; i < images.length; i++) {
      list.add(buildPhoto(images[i]));
    }
    return list;
  }

  Widget buildPhoto(String url) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        margin: EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          image: DecorationImage(
            image: AssetImage(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }


}
