
import 'package:flutter/material.dart';
import 'package:housing/provider/properties.dart';
import 'package:housing/widgets/property_item.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class SearchProperties extends SearchDelegate<PropertyItem> {

  @override
  List<Widget> buildActions(BuildContext context) {
    return<Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final size = DeviceSize(context: context);
    final properties = Provider.of<Properties>(context, listen: false).properties;
    final sProperties = (query.isNotEmpty)? properties.where((element) {
      bool status = false;
     // print('city is: ${element.city}');
      if (element.property_name.toLowerCase().contains(query.trim().toLowerCase()) ||
          element.city.toLowerCase().contains(query.trim().toLowerCase()) ||
          element.description.toLowerCase().contains(query.trim().toLowerCase())
      ) status = true;
      return status;
    }).toList(): properties;

    return (properties.length<1)? Center(child: Text(
      'Nothing to display!! Add one!!',
      textScaleFactor: 1.0,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18.0
      ),
    ),):Padding(
      padding: EdgeInsets.all(size.width*0.02),
      child: ListView.builder(

        itemCount: sProperties.length,
        itemBuilder: (context, i) {
          return ChangeNotifierProvider.value(
            value: sProperties[i],
            child: PropertyItem(),
          );
        },
      ),
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final size = DeviceSize(context: context);
    final properties = Provider.of<Properties>(context, listen: false).properties;
    final sProperties = (query.isNotEmpty)? properties.where((element) {
      bool status = false;
      if (element.property_name.toLowerCase().contains(query.trim().toLowerCase()) ||
          element.city.toLowerCase().contains(query.trim().toLowerCase()) ||
          element.description.toLowerCase().contains(query.trim().toLowerCase())
      ) status = true;
      return status;
    }).toList(): properties;

    return (properties.length<1)? Center(child: Text(
      'Nothing to display!! Add one!!',
      textScaleFactor: 1.0,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18.0
      ),
    ),):Padding(
      padding: EdgeInsets.all(size.width*0.02),
      child: ListView.builder(

        itemCount: sProperties.length,
        itemBuilder: (context, i) {
          return ChangeNotifierProvider.value(
            value: sProperties[i],
            child: PropertyItem(),
          );
        },
      ),
    );
  }





}
