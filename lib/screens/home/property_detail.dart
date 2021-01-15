import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data.dart';
import 'package:housing/models/property.dart';
import 'package:housing/screens/splash_screen.dart';
import 'package:housing/utilities/api-response.dart';
import 'package:housing/utilities/api_endpoints.dart';
import 'package:housing/utilities/api_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utilities/auth_helper.dart' as AuthHelper;
import 'package:flushbar/flushbar.dart';
import 'package:housing/utilities/http_exception.dart';


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

  List<String> featuresList = ['Parking', 'Free ka Wifi', 'Garden', 'Swimming Pool'];
  // Property2 property = Property2(
  //   "RENT",
  //   "Salu House",
  //   "3,500.00",
  //   "Miami",
  //   "3,300",
  //   "4.6",
  //   "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
  //   "assets/images/house_04.jpg",
  //   "assets/images/owner.jpg",
  //   [
  //     "assets/images/kitchen.jpg",
  //     "assets/images/bath_room.jpg",
  //     "assets/images/swimming_pool.jpg",
  //     "assets/images/bed_room.jpg",
  //     "assets/images/living_room.jpg",
  //   ],
  // );

  void add_to_bookmarks() async {
    // setState(() {
    //   _isLoading = true;
    // });
    try {
      ApiResponse response;
      String endpointaddbookmark;

      endpointaddbookmark = eProperties + id.toString() + "/add_to_bookmarks/";
      print(endpointaddbookmark);
      response =await ApiHelper().getRequest(
        endpoint: endpointaddbookmark,
      );
      print(response.data);
      print(response.errorMessage);

      Flushbar(
        message: 'Bookmarked',
        duration: Duration(seconds: 3),
      )..show(context);
      setState(() {
        property2.bookmarked = true;
      });
    } on HttpException catch (error) {
      Flushbar(
        message: '${error.toString()}',
        duration: Duration(seconds: 3),
      )..show(context);
    } catch (error) {
      print(error);
      Flushbar(
        message: 'Failed to Bookmark.',
        duration: Duration(seconds: 3),
      )..show(context);
    }
    // setState(() {
    //   _isLoading = false;
    // });
  }

  void remove_from_bookmarks() async {
    // setState(() {
    //   _isLoading = true;
    // });
    try {
      ApiResponse response;
      String endpointaddbookmark;
      endpointaddbookmark = eProperties + id.toString() + "/remove_from_bookmarks/";
      print(endpointaddbookmark);
      response =await ApiHelper().getRequest(
        endpoint: endpointaddbookmark,
      );

      Flushbar(
        message: 'Bookmarked',
        duration: Duration(seconds: 3),
      )..show(context);
      setState(() {
        property2.bookmarked = false;
      });
    } on HttpException catch (error) {
      Flushbar(
        message: '${error.toString()}',
        duration: Duration(seconds: 3),
      )..show(context);
    } catch (error) {
      print(error);
      Flushbar(
        message: 'Failed to Bookmark.',
        duration: Duration(seconds: 3),
      )..show(context);
    }
    // setState(() {
    //   _isLoading = false;
    // });
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // final property = Provider.of<Property>(context);

    return Scaffold(
        body: FutureBuilder(
      future: response,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          property2 = Property.fromJson(snapshot.data.data);
          print("Single Property");
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
                          EdgeInsets.symmetric(horizontal: 16, vertical: 48),
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
                              size: 16,
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
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      padding: EdgeInsets.symmetric(horizontal: 16),
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
                              child: (property2.bookmarked)?
                              IconButton(
                                icon: Icon(Icons.bookmark),
                                color: Colors.yellow[700],
                                iconSize: 20,
                                onPressed: () async {
                                  var result = await AuthHelper.autoLogin();
                                  if (result){
                                    remove_from_bookmarks();
                                  }
                                  else {
                                    Navigator.pushNamed(context, '/login');
                                  }
                                },
                              )
                              : IconButton(
                                icon: Icon(Icons.bookmark_border),
                                color: Colors.yellow[700],
                                iconSize: 20,
                                onPressed: () async {
                                  var result = await AuthHelper.autoLogin();
                                  if (result){
                                    add_to_bookmarks();
                                  }
                                  else {
                                    Navigator.pushNamed(context, '/login');
                                  }
                                },
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
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
                maxChildSize: 0.95,
                builder: (context, scrollController){
                  return Container(
                    // height: size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      controller: scrollController,
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
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
                                        image: AssetImage("assets/images/owner.jpg"),
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
                                      child: IconButton(
                                        icon: Icon(
                                        Icons.message),
                                        color: Colors.yellow[700],
                                        iconSize: 20,
                                        onPressed: ()=> {
                                          launch("whatsapp://send?phone=919999998627"),}
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
                            right: 16,
                            left: 16,
                            bottom: 16,
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
                            right: 16,
                            left: 16,
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
                            right: 16,
                            left: 16,
                            bottom: 16,
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
                            right: 16,
                            left: 16,
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
                        Container(
                          height: size.height*0.2,
                          padding: EdgeInsets.only(
                            right: 16,
                            left: 16,
                            bottom: 16,
                          ),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: property2.photos.length,
                            itemBuilder: (context, index){
                              return Container(
                                width: size.width*0.5,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(property2.photos[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            right: 16,
                            left: 16,
                            bottom:8,
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
                          padding: const EdgeInsets.symmetric(horizontal:16.0),
                          child: Wrap(
                            spacing: 12.0,
                            children: property2.property_features.map((e) => Chip(
                              label: Text(e, style: TextStyle(fontSize: 16, color: Colors.black87),),
                              backgroundColor: Colors.yellow[700],
                              deleteIcon: null,
                            )).toList(),
                          ),
                        ),

                      ],
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
      width: 16,
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
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }


}
