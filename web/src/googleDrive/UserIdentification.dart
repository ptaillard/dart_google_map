library UserIdentification;

import 'dart:html';
import 'dart:async';

import "package:google_drive_v2_api/drive_v2_api_browser.dart" as drivelib;
import "package:google_oauth2_client/google_oauth2_browser.dart" as oauth;
import 'EtatIdentificationListener.dart';

class UserIdentification {
  List<EtatIdentificationListener> listeners = new List<EtatIdentificationListener>();
  
  final CLIENT_ID = "796343192238.apps.googleusercontent.com";
  final SCOPES = [drivelib.Drive.DRIVE_FILE_SCOPE];
  
  var auth = null;
  
  var loginElement = querySelector('#login') as ButtonElement; 
  var logoutElement = querySelector('#logout') as ButtonElement;
  
  UserIdentification(){
    this.auth = new oauth.GoogleOAuth2(CLIENT_ID, SCOPES);
    
    loginElement.onClick.listen((e){
      _getToken().then((token){
        loginElement..disabled = true;
        logoutElement..disabled = false;
        login(token);
      });
    });
    
    logoutElement.onClick.listen((e){
      deconnect(e);
    });
  }
  
  void addListener(EtatIdentificationListener listener) {
    listeners.add(listener);
    listener.authentification(auth);
  }
  
  void login(token) {
    for (var listener in listeners) {
      listener.login(token);
    }  
  }
  
  void logout() {
    for (var listener in listeners) {
      listener.logout();
    } 
  }
  

  void deconnect(e) {
    auth.logout();
    loginElement..disabled = false;
    logoutElement..disabled = true;
    logout();
  }
  
  Future <oauth.Token> _getToken(){
    var completer = new Completer();
    auth.login(immediate: false).then((token) {
      completer.complete(token);
    });
    return completer.future;
  }


/*
Future <oauth.Token> _getToken(){
  var completer = new Completer();
  var clientId = window.localStorage["client_id"];
  var auth = new oauth.GoogleOAuth2(clientId, SCOPES);

  if (!window.localStorage.containsKey('token')){
    auth.login().then((oauth.Token token) {
      window.localStorage["token"] = token.toJson();
      completer.complete(token);
    });
  } else {
    Map map = JSON.decode(window.localStorage["token"]);
    var type = map["type"];
    var data = map["data"];
    var expiry = new DateTime.fromMillisecondsSinceEpoch(map['expiry']);
    var token = new oauth.Token(type,data,expiry);
    var request = new HttpRequest();
    request.open("GET", "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=$data");
    request.onLoad.listen((e){
      if(request.status == 200) {
        var token = new oauth.Token(type,data,expiry);
        completer.complete(token);
      }else
      {
        auth.login().then((oauth.Token token) {
          window.localStorage["token"] = token.toJson();
          completer.complete(token);
        });
      }
    });
    try {
      request.send();
    } catch(e){
      auth.login().then((oauth.Token token) {
        window.localStorage["token"] = token.toJson();
        completer.complete(token);
      });
    }
  }
  return completer.future;
}*/

}