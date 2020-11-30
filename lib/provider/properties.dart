import 'package:flutter/cupertino.dart';
import 'package:housing/models/property.dart';
import 'package:housing/utilities/api-response.dart';
import 'package:housing/utilities/api_endpoints.dart';
import 'package:housing/utilities/api_helper.dart';

class Property with ChangeNotifier {
  List<dynamic> _properties = [];
  List<dynamic> get properties {
    return [..._properties];
  }

  Future<void> fetchAllProperties() async {
    final response = await ApiHelper().getRequest(endpoint: eMyProperties);
    _properties = response.data;
    _properties.map((e) => e as Map<String, dynamic>).toList();
    print(response.data);
  }

  Map<String, dynamic> findById(int id) {
    return _properties.firstWhere((element) {
      return element['id'] == id;
    }, orElse: () => print('No matching element.'));
  }
}
