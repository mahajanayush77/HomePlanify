import 'package:flutter/cupertino.dart';
import 'package:housing/models/property.dart';
import 'package:housing/utilities/api-response.dart';
import 'package:housing/utilities/api_endpoints.dart';
import 'package:housing/utilities/api_helper.dart';

class Properties with ChangeNotifier {
  List<Property> _properties = [];
  List<Property> get properties {
    return [..._properties];
  }

  Future<void> fetchAllProperties() async {
    final response = await ApiHelper().getWithoutAuthRequest(
      endpoint: eProperties,
      query: {
        'visible': 'true',
        'verified': 'true',
      },
    );
    if(!response.error){
      //_properties = response.data;
      _properties.clear();
      List<Property> list = response.data.map<Property>((e) => Property.fromJson(e)).toList();
      _properties.addAll(list);
      print(response.data);
    }
   
  }

  Property findById(int id) {
    return _properties.firstWhere((element) {
      return element.id == id;
    }, orElse: () => Property());
  }
}