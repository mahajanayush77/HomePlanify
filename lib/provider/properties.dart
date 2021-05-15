import 'package:flutter/cupertino.dart';
import '../models/property.dart';
import '../utilities/api-response.dart';
import '../utilities/api_endpoints.dart';
import '../utilities/api_helper.dart';

// Properties provider

class Properties with ChangeNotifier {
  List<Property> _properties = [];
  List<Property> get properties {
    return [..._properties];
  }

  // fetch all listed properties which are also verified and visible
  Future<ApiResponse> fetchAllProperties([Map<String, dynamic> query]) async {
    ApiResponse response = await ApiHelper().getWithoutAuthRequest(
      endpoint: eProperties,
      query: query!=null?query:
      {
        'visible': 'true',
        'verified': 'true',
      },
    );
    if(!response.error){
      _properties.clear();
      List<Property> list = response.data.map<Property>((e) => Property.fromJson(e)).toList();
      _properties.addAll(list);
    }
    return response;
  }

  Property findById(int id) {
    return _properties.firstWhere((element) {
      return element.id == id;
    }, orElse: () => Property());
  }
}
