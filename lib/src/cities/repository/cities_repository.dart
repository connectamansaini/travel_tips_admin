import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:travel_tips_admin/src/cities/model/city.dart';

class CitiesRepository {
  Future<List<City>> getCities() async {
    try {
      final response = await rootBundle.loadString('assets/json/cities.json');
      final data = jsonDecode(response) as List;
      final cities =
          data.map((e) => City.fromJson(e as Map<String, dynamic>)).toList();
      return cities;
    } catch (e) {
      rethrow;
    }
  }
}
