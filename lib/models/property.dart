import 'package:flutter/cupertino.dart';
import '../utilities/api-response.dart';
import '../utilities/api_endpoints.dart';
import '../utilities/api_helper.dart';
import '../utilities/http_exception.dart';

class Property extends ChangeNotifier {
  int id;
  String type;
  String property_name;
  String description;
  String city;
  int bedrooms;
  int bathrooms;
  int rooms;
  String construction_status;
  String available_from;
  int price_sq;
  int total_price;
  String additional_features;
  bool visible;
  bool verified;
  int views;
  String label;
  String dateadded;
  String main_image;
  String youtube_video;
  String youtube_video_2;
  String video;
  bool featured;
  int owner;
  List features;
  List photos;
  List property_features;
  bool bookmarked;


  Property({
    this.id,
    this.type,
    this.property_name,
    this.city,
    this.bedrooms,
    this.bathrooms,
    this.rooms,
    this.construction_status,
    this.available_from,
    this.price_sq,
    this.total_price,
    this.additional_features,
    this.visible,
    this.verified,
    this.description,
    this.views,
    this.label,
    this.dateadded,
    this.main_image,
    this.youtube_video,
    this.youtube_video_2,
    this.video,
    this.featured,
    this.owner,
    this.features,
    this.photos,
    this.property_features,
    this.bookmarked,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    print(json["bookmarked"]);
    return Property(
      id: json['id'],
      type: json['type'],
      property_name: json['property_name'],
      city: json['city'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      description: json['description'] ?? '',
      rooms: json['rooms'],
      construction_status: json['construction_status'],
      available_from: json['available_from'],
      price_sq: json['price_sq'],
      total_price: json['total_price'],
      additional_features: json['additional_features'],
      visible: json['visible'],
      verified: json['verified'],
      views: json['views'],
      label: json['label'],
      dateadded: json['dateadded'],
      main_image: json['main_image'],
      youtube_video: json['youtube_video'],
      youtube_video_2: json['youtube_video_2'],
      video: json['video'],
      featured: json['featured'],
      owner: json['owner'],
      features: json['features'],
      photos: json['photos'],
      property_features: json['property_features'],
      bookmarked: json['bookmarked'],
    );
  }

  dynamic toJson() => {
        'id': id,
        'type': type,
        'property_name': property_name,
        'city': city,
        'bedrooms': bedrooms,
        'bathrooms': bathrooms,
        'rooms': rooms,
        'construction_status': construction_status,
        'available_from': available_from,
        'price_sq': price_sq,
        'total_price': total_price,
        'additional_features': additional_features,
        'visible': visible,
        'verified': verified,
        'views': views,
        'label': label,
        'description': description,
        'dateadded': dateadded,
        'main_image': main_image,
        'youtube_video': youtube_video,
        'youtube_video_2': youtube_video_2,
        'video': video,
        'featured': featured,
        'owner': owner,
        'features': features,
        'photos': photos,
        'property_features': property_features,
        'bookmarked': bookmarked,
      };

  void addtobookmarks() async {
    //Remove from the list
    bookmarked = true;
    notifyListeners();

    try{

      String endpointaddbookmark;
      endpointaddbookmark = eProperties + id.toString() + "/add_to_bookmarks/";
      ApiResponse response =await ApiHelper().getRequest(
        endpoint: endpointaddbookmark,
      );

      if(response.error){
        bookmarked = false;
        notifyListeners();
      }

    }catch(error){
      bookmarked = false;
      notifyListeners();
      throw HttpException(message: 'Failed to Bookmark');
    }
    notifyListeners();
  }

  void removefrombookmarks(int id) async {
    bookmarked = false;
    notifyListeners();

    try{

      String endpointaddbookmark;
      endpointaddbookmark = eProperties + id.toString() + "/remove_from_bookmarks/";
      ApiResponse response =await ApiHelper().getRequest(
        endpoint: endpointaddbookmark,
      );

      if(response.error){
        bookmarked = true;
        notifyListeners();
      }
    }catch(error){
      bookmarked = true;
      notifyListeners();
      throw HttpException(message: 'Failed to remove from Bookmarks');
    }
    notifyListeners();
  }
}
