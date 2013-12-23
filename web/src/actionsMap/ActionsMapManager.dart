library ActionMapManager;

import 'dart:html';
import 'package:google_maps/google_maps.dart';
import '../TravelManager.dart';
import 'ActionInterface.dart';
import 'ActionCity.dart';
import 'ActionNop.dart';
import 'ActionAeroport.dart';

class ActionsMapManager {
  
  GMap map;
  TravelManager travelManager;
  ActionInterface actionInterface;
  int action = 0;
  
  ActionsMapManager(TravelManager travelManager, GMap map) {
    this.travelManager = travelManager;
    this.map = map;
    actionInterface = new ActionNop();
    initEvent();
  }
  
  void initEvent() {
    map.onClick.listen((e) => addLocation(e));
    querySelector('#move').onClick.listen((e) => actionUserMove(e));
    querySelector('#ville').onClick.listen((e) => actionUserVille(e));
    querySelector('#aeroport').onClick.listen((e) => actionUserAeroport(e));
  }
  
  void actionUserVille(e) {
    actionInterface = new ActionCity(travelManager);
    querySelector('#infos')..text = 'Action ville';
  }

  void actionUserAeroport(e) {
    actionInterface = new ActionAeroport(travelManager);
    querySelector('#infos')..text = 'Action aeroport';
  }

  void actionUserMove(e) {
    actionInterface = new ActionNop();
    querySelector('#infos')..text = 'Action move';
  }

  void addLocation(e) {
    querySelector('#infos')..text = '';
    actionInterface.add(e.latLng);
  }
}
