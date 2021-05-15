import 'package:flutter/cupertino.dart';
import '../models/property.dart';
import '../utilities/api-response.dart';
import '../utilities/api_endpoints.dart';
import '../utilities/api_helper.dart';
import '../utilities/http_exception.dart';

// Bookmarked properties Provider
class Bookmarks with ChangeNotifier {
  List<Property> _myProp = [];
  List<Property> get myProp {
    return [..._myProp];
  }

  Future<ApiResponse> fetchProducts() async {
    ApiResponse response;
    response =await ApiHelper().getRequest(
      endpoint: eBookmarks,
    );
    print(response);
    _myProp.clear();
    if(!response.error){
      List<Property> list = response.data.map<Property>((e)=> Property.fromJson(e)).toList();
      _myProp.addAll(list);
    }
    return response;
  }

  void addtobookmarks(int id) async {
    final existingIndex = _myProp.indexWhere((prod) => prod.id == id);
    var existingProp = _myProp[existingIndex];
    _myProp.removeWhere((prod) => prod.id == id);
    notifyListeners();

    try{
      String endpointaddbookmark;
      endpointaddbookmark = eProperties + id.toString() + "/add_to_bookmarks/";
      ApiResponse response =await ApiHelper().getRequest(
        endpoint: endpointaddbookmark,
      );

      if(response.error){
        _myProp.insert(existingIndex, existingProp);
        notifyListeners();
      }
    }catch(error){
      _myProp.insert(existingIndex, existingProp);
      notifyListeners();
      throw HttpException(message: 'Failed to add to Bookmarks');
    }
    notifyListeners();
  }

  void removefrombookmarks(int id) async {
    //Remove from the list
    final existingIndex = _myProp.indexWhere((prod) => prod.id == id);
    var existingProp = _myProp[existingIndex];
    _myProp.removeWhere((prod) => prod.id == id);
    notifyListeners();

    try{

      String endpointaddbookmark;
      endpointaddbookmark = eProperties + id.toString() + "/remove_from_bookmarks/";
      ApiResponse response =await ApiHelper().getRequest(
        endpoint: endpointaddbookmark,
      );

      if(response.error){
        _myProp.insert(existingIndex, existingProp);
        notifyListeners();
      }
    }catch(error){
      _myProp.insert(existingIndex, existingProp);
      notifyListeners();
      throw HttpException(message: 'Failed to remove from Bookmarks');
    }
    notifyListeners();
  }

  Property findById(int id) {
    return _myProp.firstWhere((element) {
      return element.id == id;
    }, orElse: () => Property());
  }
}
