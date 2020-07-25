import '../models/featured_deal.dart';
import 'package:flutter/material.dart';

class FeaturedDeals {
  List<FeaturedDeal> _list = [];
  FeaturedDeals() {
    _list.addAll([
      FeaturedDeal(
          propertyTitle: 'DLF FarmGreens',
          price: '50 - 80 L',
          expiry: 2,
          company: 'DLF Communities',
          location: 'Sector 10 Gurgaon',
          image: null),
      FeaturedDeal(
          propertyTitle: 'DLF CyberCity',
          price: '20 - 50 L',
          expiry: 2,
          company: 'DLF Communities',
          location: 'Faridabad',
          image: null),
      FeaturedDeal(
          propertyTitle: 'DLF FarmGreens',
          price: '40 - 80 L',
          expiry: 2,
          company: 'DLF Communities',
          location: 'D-Block Vasant Vihar',
          image: null),
      FeaturedDeal(
          propertyTitle: 'DLF FarmGreens',
          price: '30 - 60 L',
          expiry: 2,
          company: 'DLF Communities',
          location: 'M-Block Greater Kailash',
          image: null),
    ]);
  }
  List<FeaturedDeal> get list => _list;
}
