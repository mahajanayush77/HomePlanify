import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:housing/utilities/api-response.dart';
import 'package:housing/utilities/api_endpoints.dart';
import 'package:housing/utilities/api_helper.dart';
import 'package:http/http.dart' as http;
import '../screens/news/article.dart';
import '../constant.dart';
import '../widgets/bottom_bar.dart';

class news_page extends StatefulWidget {
  @override
  _news_pageState createState() => _news_pageState();
}

class _news_pageState extends State<news_page> {

  // endpoint for blog posts
  final String url = "https://www.homeplanify.com/api/blog-posts/";
  List data;
  Future<ApiResponse> _response;
  var blogUrl;

  @override
  void initState() {
    super.initState();
    blogUrl = Uri.encodeFull(url);
    this.getJsonData();
  }

  Future<void> getJsonData() async {
    // GET request

    var response = await http.get(
        blogUrl
    );
    setState(
      () {
        var convertDataToJson = json.decode(response.body);
        data = convertDataToJson;
      },
    );
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
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
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
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ArticleOnePage(index: index)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.green,
                            ),
                            child: Image.network(
                              data[index]['main_image'],
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                            child: Visibility(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data[index]["title"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
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

  // Heading widget
  Padding _buildHeading(String title) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600),
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
}
