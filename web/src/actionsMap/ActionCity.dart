library ActionCity;

import 'ActionInterface.dart';
import '../TravelManager.dart';
import '../location/LocationFactory.dart';
import 'package:google_maps/google_maps.dart';

class ActionCity implements ActionInterface {
  TravelManager travelManager;
  
  ActionCity(TravelManager travelManager) {
    this.travelManager = travelManager;
  }
  
  void add(LatLng latLng) {
    travelManager.appendLocation(LocationFactory.createCity('city', latLng, new DateTime(2013, 06, 16)));
  }
}