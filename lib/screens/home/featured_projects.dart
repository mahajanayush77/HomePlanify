import 'package:flutter/material.dart';
import 'package:housing/screens/home/projects_list.dart';
import 'package:housing/screens/splash_screen.dart';
import 'package:housing/utilities/api-response.dart';
import 'package:housing/utilities/api_endpoints.dart';
import 'package:housing/utilities/api_helper.dart';
import 'package:housing/screens/webview.dart';
import 'package:google_fonts/google_fonts.dart';



class FeaturedProjects extends StatefulWidget {
  @override
  _FeaturedProjectsState createState() => _FeaturedProjectsState();
}

class _FeaturedProjectsState extends State<FeaturedProjects> {

  Future<ApiResponse> _properties;
  @override
  void initState() {
    // TODO: implement initState
    _properties = ApiHelper().getWithoutAuthRequest(
      endpoint: eFeaturedProperties,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Featured Projects"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.0,),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: FutureBuilder(
                future: _properties,
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    return ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 15),
                      shrinkWrap: true,
                      itemCount: snapshot.data.data.length,
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
                  } else if (snapshot.hasError){
                    return Text("${snapshot.error}");
                  };
                  return SplashScreen();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class deal_card extends StatelessWidget {
  final String propertyTitle;
  final String location;
  final String image;
  final String link;
  deal_card({this.location, this.propertyTitle, this.image, this.link});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.55,
      width: MediaQuery.of(context).size.width * 0.65,
      child: Card(
        color: Colors.grey[200],
        elevation: 5.0,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => WebScreen(
                url: link,
              ),
            ));},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Image(
                    image: NetworkImage(
                      image,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '$propertyTitle',
                        textAlign: TextAlign.start,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 2.5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '$location',
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
