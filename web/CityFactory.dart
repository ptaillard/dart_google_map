library CityFactory;

import 'package:google_maps/google_maps.dart';
import 'City.dart';

class CityFactory {
  
  CityFactory();
  
  static City create(String name, LatLng coordinate, DateTime date) => new City(name, coordinate, date);
}