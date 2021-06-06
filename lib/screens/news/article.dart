import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../widgets/rounded_container.dart';

class ArticleOnePage extends StatefulWidget {
  final int index;

  ArticleOnePage({this.index});

  static final String path = "package/lib/src/pages/blog/article1.dart";

  @override
  _ArticleOnePageState createState() => _ArticleOnePageState(index: index);
}

class _ArticleOnePageState extends State<ArticleOnePage> {
  final String url = "https://www.homeplanify.com/api/blog-posts/";
  List data;
  var blogUrl;

  @override
  void initState() {
    super.initState();
    blogUrl = Uri.encodeFull(url);
    this.getJsonData();
  }

  Future<void> getJsonData() async {
    var response = await http.get(blogUrl);
    setState(
      () {
        var convertDataToJson = json.decode(response.body);
        data = convertDataToJson;
      },
    );
  }

  final int index;
  _ArticleOnePageState({this.index});

  // image carousel
  Widget _slideImage() {
    return RoundedContainer(
      height: 270,
      borderRadius: BorderRadius.circular(0),
      color: Colors.amber[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 13.0,
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
                        const SizedBox(width: 10.0),
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.red,
                            child: ListView.builder(
                              itemCount: data == null ? 0 : 1,
                              itemBuilder: (BuildContext context, idx) {
                                return Image(
                                  image: NetworkImage(
                                      data[idx]['image${index + 1}']),
                                  fit: BoxFit.contain,
                                );
                              },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(data[index]['title']),
        ),
        body: ListView.builder(
            itemCount: data == null ? 0 : 1,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      _slideImage(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(data[index]['date']),
                            ),
                          ],
                        ),
                        Text(
                          data[index]['title'],
                          softWrap: true,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          data[index]['content'],
                          textAlign: TextAlign.justify,
                          softWrap: true,
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            wordSpacing: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }));
  }
}
