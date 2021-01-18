import 'package:flutter/cupertino.dart';
import 'package:housing/utilities/api-response.dart';
import 'package:housing/utilities/api_endpoints.dart';
import 'package:housing/utilities/api_helper.dart';
import 'package:housing/utilities/http_exception.dart';

class Filter extends ChangeNotifier {
  String search;
  String type;
  int bedrooms;
  int bathrooms;
  int rooms;
  String construction_status;
  int price_start;
  int price_end;
  bool featured;
  List features;

  // Filter({
  //   this.search,
  //   this.type,
  //   this.bedrooms,
  //   this.bathrooms,
  //   this.rooms,
  //   this.construction_status,
  //   this.price_start,
  //   this.price_end,
  //   this.featured,
  //   this.features,
  // });

  Map<String, dynamic> toQuery(){
    Map<String, dynamic> query = {
      'visible': 'true',
      'verified': 'true',
    };

    if (search != null && search.isNotEmpty) query["search"] = search;
    if (type != null && type.isNotEmpty) query["type"] = type;
    if (bedrooms != null) query["bedrooms"] = bedrooms;
    if (rooms != null) query["rooms"] = rooms;
    if (bathrooms != null) query["bathrooms"] = bathrooms;
    if (construction_status != null && construction_status.isNotEmpty) query["construction_status"] = construction_status;
    if (price_start != null) query["price_start"] = price_start;
    if (price_end != null) query["price_end"] = price_end;
    if (featured != null) query["featured"] = featured;


    return query;

  }

  // Map<String, dynamic> toJson() => {
  //
  //     'visible': 'true',
  //     'verified': 'true',
  //     search != null ? "search": search : null,
  //     type != null ? "search": type : null,
  //     bedrooms != null ? "bedrooms": bedrooms : null,
  //     rooms != null ? "rooms": rooms : null,
  //     bathrooms != null ? "bathrooms": bathrooms : null,
  //     construction_status != null ? "construction_status": construction_status : null,
  //     price_start != null ? "minprice": price_start : null,
  //     price_end != null ? "maxprice": price_end : null,
  //     featured != null ? "featured": featured : null,
  //   //   orderby != null ? "orderby": orderby : null,
  //   //
  //   // "search": search,
  //   // "type": type,
  //   // "bedrooms": bedrooms,
  //   // "bathrooms": bathrooms,
  //   // "rooms": rooms,
  //   // "construction_status": construction_status,
  //   // "price_start": price_start,
  //   // "price_end": price_end,
  //   // "featured": featured,
  //   // "features": features,
  // };

  void saveFilters( type, bedrooms, bathrooms, rooms, construction_status, price_start, price_end, featured, features){
    this.type = type;
    this.bedrooms = bedrooms;
    this.bathrooms = bathrooms;
    this.rooms = rooms;
    this.construction_status = construction_status;
    this.price_start = price_start;
    this.price_end = price_end;
    this.featured = featured;
    this.features = features;
  }

  void updateSearch(search){
    this.search = search;
  }

}
