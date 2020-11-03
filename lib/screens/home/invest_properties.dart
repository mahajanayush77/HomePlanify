import 'package:flutter/material.dart';
import 'package:housing/screens/home/projects_list.dart';
import 'package:housing/screens/splash_screen.dart';
import 'package:housing/utilities/api-response.dart';
import 'package:housing/utilities/api_endpoints.dart';
import 'package:housing/utilities/api_helper.dart';
import 'package:housing/screens/webview.dart';

class InvestProperties extends StatefulWidget {
  @override
  _InvestPropertiesState createState() => _InvestPropertiesState();
}

class _InvestPropertiesState extends State<InvestProperties> {

  Future<ApiResponse> _properties;
  @override
  void initState() {
    // TODO: implement initState
    _properties = ApiHelper().getWithoutAuthRequest(
      endpoint: eInvestProperties,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invest with HomePlanify"),
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
                        return InvestProp(
                          title: item['title'],
                          image: item['image'],
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







class InvestProp extends StatelessWidget {
  String title;
  String image;
  String link;
  InvestProp({this.title, this.image, this.link});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.65,
      height: MediaQuery.of(context).size.height / 4,
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
