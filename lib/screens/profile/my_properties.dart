import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housing/screens/home/property_detail.dart';
import 'package:housing/screens/splash_screen.dart';
import 'package:housing/utilities/api-response.dart';
import 'package:housing/utilities/api_endpoints.dart';
import 'package:housing/utilities/api_helper.dart';
import '../data.dart';
import '../filter.dart';










class MyProperties extends StatefulWidget {
  @override
  _MyPropertiesState createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> {
  Future<ApiResponse> _properties;

  void delete_property(id) {
    Future<ApiResponse> _response_delete;

    _response_delete = ApiHelper().deleteRequest(
      endpoint: eProperties + id.toString() + "/",
    );
    _properties = ApiHelper().getRequest(
      endpoint: eMyProperties,
    );
    setState(() {
    });
  }


  void initState() {
    // TODO: implement initState
    _properties = ApiHelper().getRequest(
      endpoint: eMyProperties,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Properties'),
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
                future: _properties,
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    return ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 15),
                      shrinkWrap: true,
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (context, index){
                        final Map<String, dynamic> property = snapshot.data.data.toList()[index];
                        // print(property);
                        return GestureDetector(
                            onTap: () {
                          // print(index);
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => Detail(id: property['id'])));
                        },
                        child: Prop(
                          id: property['id'],
                          type: property['type'],
                          property_name: property['property_name'],
                          city: property['city'].split(" ")[0],
                          construction_status: property['construction_status'],
                          available_from: property['available_from'],
                          bedrooms: property['bedrooms'],
                          total_price: property['total_price'],
                          views: property['views'],
                          main_image: property['main_image'],
                          delete_action: delete_property,
                        )
                        );
                      },
                    );
                  } else if (snapshot.hasError){
                    return Text("${snapshot.error}");
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
  Function delete_action;


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
    this.delete_action,
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


              Row(
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
                    flex: 2,
                    child: Column(

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.black,
                              onPressed: (){},
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: (){
                                return delete_action(id);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: Column(
                  //     children: [
                  //       IconButton(
                  //         icon: Icon(Icons.delete),
                  //         color: Colors.black,
                  //         onPressed: (){},
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // IconButton(
                  //   icon: Icon(Icons.delete),
                  //   color: Colors.red,
                  //   onPressed: (){},
                  // ),
                ],
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
                            Icons.zoom_out_map,
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
