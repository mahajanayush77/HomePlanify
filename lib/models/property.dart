import 'package:flutter/cupertino.dart';

class Property extends ChangeNotifier{
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
  });

  factory Property.fromJson(Map<String, dynamic> json) {
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
        'description':description,
        'dateadded': dateadded,
        'main_image': main_image,
        'youtube_video': youtube_video,
        'youtube_video_2': youtube_video_2,
        'video': video,
        'featured': featured,
        'owner': owner,
        'features': features,
      };
}
