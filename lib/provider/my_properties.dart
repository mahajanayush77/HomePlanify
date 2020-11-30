import 'package:flutter/cupertino.dart';
import 'package:housing/screens/profile/my_properties.dart';

import 'package:housing/utilities/api-response.dart';
import 'package:housing/utilities/api_endpoints.dart';
import 'package:housing/utilities/api_helper.dart';

class MyProperties with ChangeNotifier {
  List<dynamic> _myProp = [];
  List<dynamic> get myProp {
    return [..._myProp];
  }

  Future<ApiResponse> fetchProducts() async {
    Future<ApiResponse> _properties;
    _properties = ApiHelper().getRequest(
      endpoint: eMyProperties,
    );
    _properties.then((value) => _myProp = value.data);

    return _properties;
  }

  void properties(List<Map<String, dynamic>> value) {
    _myProp = value;
  }

  void deleteProperty(int id) async {
    await ApiHelper().deleteRequest(
      endpoint: eMyProperties + id.toString() + "/",
    );

    notifyListeners();
  }
}
