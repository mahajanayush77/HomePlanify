import 'package:flutter/cupertino.dart';

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
  String orderby;

  Map<String, String> toQuery(){
    Map<String, String> query = {
      'visible': 'true',
      'verified': 'true',
    };

    if (search != null && search.isNotEmpty) query["search"] = search;
    if (type != null && type.isNotEmpty) query["type"] = type;
    if (bedrooms != null) query["bedrooms"] = bedrooms.toString();
    if (rooms != null) query["rooms"] = rooms.toString();
    if (bathrooms != null) query["bathrooms"] = bathrooms.toString();
    if (construction_status != null && construction_status.isNotEmpty) query["construction_status"] = construction_status;
    if (price_start != null) query["price_start"] = price_start.toString();
    if (price_end != null) query["price_end"] = price_end.toString();
    if (featured != null) query["featured"] = featured.toString();
    if (orderby != null && orderby.isNotEmpty) query["orderby"] = orderby;
    print(query);
    return query;

  }


  void saveFilters( type, bedrooms, bathrooms, rooms, construction_status, price_start, price_end, featured, orderby){
    this.type = type;
    this.bedrooms = bedrooms;
    this.bathrooms = bathrooms;
    this.rooms = rooms;
    this.construction_status = construction_status;
    this.price_start = price_start;
    this.price_end = price_end;
    this.featured = featured;
    this.orderby = orderby;
  }

  void updateSearch(search){
    this.search = search;
  }

}
