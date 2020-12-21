import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:housing/widgets/bottom_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:housing/screens/news/article.dart';
import '../constant.dart';
import '../widgets/rounded_container.dart';
import 'news/network_image.dart';
import 'package:http/http.dart' as http;

const List<String> images = [
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media',
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F2.jpg?alt=media',
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F3.jpg?alt=media',
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F4.jpg?alt=media',
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F5.jpg?alt=media',
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F6.jpg?alt=media',
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F7.jpg?alt=media',
];



class news_page extends StatefulWidget {
  @override
  _news_pageState createState() => _news_pageState();
}

class _news_pageState extends State<news_page> {

  final String url = "https://www.homeplanify.com/api/blog-posts/";
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<void> getJsonData() async{
    var response = await http.get(
      Uri.encodeFull(url),
    );

    print(response.body);

    setState((){
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson;
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'News',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: data == null? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            child: Column(
              children: [
                // _buildNewsHeading("News"),
                const SizedBox(height: 10.0),
                _buildHeading("Popular posts"),

                Card(
                  child: InkWell(
                    onTap: () {
                      print(index);
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => ArticleOnePage(index: index)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                          ),
                          Expanded(
                            child: Visibility(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data[index]["title"],
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    data[index]["content"],
                                    style: TextStyle(),
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          );
        },
      ),


      bottomNavigationBar: bottom_bar(2),
    );
  }

  Padding _buildHeading(String title) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.grey.shade600
              ),
            ),
          ),
          MaterialButton(
            elevation: 0,
            textColor: Colors.white,
            color: kPrimaryBackgroundColor,
            height: 0,
            child: Icon(Icons.keyboard_arrow_right),
            minWidth: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: const EdgeInsets.all(2.0),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  RoundedContainer _buildFeaturedNews() {
    return RoundedContainer(
      height: 270,
      borderRadius: BorderRadius.circular(0),
      color: Colors.amber[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Featured News",
            style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Swiper(
              pagination: SwiperPagination(margin: const EdgeInsets.only()),
              viewportFraction: 0.9,
              itemCount: 4,
              loop: false,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundedContainer(
                    borderRadius: BorderRadius.circular(4.0),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Text(
                            "A complete set of design elements, and their intitutive design.",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.red,
                            child: PNetworkImage(
                              images[1],
                              fit: BoxFit.cover,
                              height: 210,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _buildItem extends StatelessWidget {
  const _buildItem({
    @required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ArticleOnePage()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    "Lorem ipsum dolor sit amet, consecteutur adsd Ut adipisicing dolore incididunt minim",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                      "Mollit aliquip fugiat veniam reprehenderit irure commodo eu aute ex commodo."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}