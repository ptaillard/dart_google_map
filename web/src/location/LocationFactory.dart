library LocationFactory;

import 'package:google_maps/google_maps.dart';
import 'City.dart';
import 'Aeroport.dart';
import 'Restaurant.dart';
import 'VisitSite.dart';

class LocationFactory {
  
  LocationFactory();
  
  static City createCity(String name, LatLng coordinate, DateTime date) => new City(name, coordinate, date);
  static Aeroport createAeroport(String name, LatLng coordinate, DateTime date) => new Aeroport(name, coordinate, date);
  static Restaurant createRestaurant(String name, LatLng coordinate, DateTime date) => new Restaurant(name, coordinate, date);
  static VisitSite createVisit(String name, LatLng coordinate, DateTime date) => new VisitSite(name, coordinate, date);
}
