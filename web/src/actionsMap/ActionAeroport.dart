library ActionAeroport;

import 'ActionInterface.dart';
import '../TravelManager.dart';
import '../location/LocationFactory.dart';
import 'package:google_maps/google_maps.dart';

class ActionAeroport implements ActionInterface {
  TravelManager travelManager;
  
  ActionAeroport(TravelManager travelManager) {
    this.travelManager = travelManager;
  }
  
  void add(LatLng latLng) {
    travelManager.appendLocation(LocationFactory.createAeroport('aeroport', latLng, new DateTime(2013, 06, 16)));
  }
}