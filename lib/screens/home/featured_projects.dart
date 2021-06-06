import 'package:flutter/material.dart';
import '../splash_screen.dart';
import '../../utilities/api-response.dart';
import '../../utilities/api_endpoints.dart';
import '../../utilities/api_helper.dart';
import '../../widgets/hot_deal_card.dart';

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
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 15),
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
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  ;
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
