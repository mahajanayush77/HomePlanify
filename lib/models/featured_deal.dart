import 'package:flutter/material.dart';

class FeaturedDeal {
  String propertyTitle;
  String price;
  int expiry;
  String company;
  String location;
  Image image;

  FeaturedDeal(
      {this.propertyTitle,
      this.price,
      this.expiry,
      this.company,
      this.location,
      this.image});
}
