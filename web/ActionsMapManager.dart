
import 'dart:html';
import 'package:google_maps/google_maps.dart';
import 'LocationFactory.dart';
import 'TravelManager.dart';

class ActionsMapManager {
  
  GMap map;
  TravelManager travelManager;
  int action = 0;
  
  ActionsMapManager(TravelManager travelManager, GMap map) {
    this.travelManager = travelManager;
    this.map = map;
    initEvent();
  }
  
  void initEvent() {
    map.onClick.listen((e) => addLocation(e));
    querySelector('#move').onClick.listen((e) => actionUserMove(e));
    querySelector('#ville').onClick.listen((e) => actionUserVille(e));
    querySelector('#aeroport').onClick.listen((e) => actionUserAeroport(e));
  }

  void actionUserVille(e) {
    action = 1;
    querySelector('#infos')..text = 'Action ville';
  }

  void actionUserAeroport(e) {
    action = 2;
    querySelector('#infos')..text = 'Action aeroport';
  }

  void actionUserMove(e) {
    action = 0;
    querySelector('#infos')..text = 'Action move';
  }

  void addLocation(e) {
    querySelector('#infos')..text = '';
    if(action == 1) {
      travelManager.appendLocation(LocationFactory.createCity('city', new LatLng(37.800165,-122.433116), new DateTime(2013, 06, 16)));
    }
    else if(action == 2) {
      travelManager.appendLocation(LocationFactory.createAeroport('aeroport', new LatLng(37.700165,-122.533116), new DateTime(2013, 06, 16)));
    }
  }
}
