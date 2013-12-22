library GoogleDriveManager;

import 'dart:html';
import "dart:typed_data";
import 'EtatIdentificationListener.dart';
import 'files.dart';

import "package:google_drive_v2_api/drive_v2_api_browser.dart" as drivelib;
import "package:google_drive_v2_api/drive_v2_api_client.dart" as client;

class GoogleDriveManager extends EtatIdentificationListener {
  
  var drive = null;
  final InputElement fileId = querySelector("#fileId");
  final DivElement output = querySelector('#drive');
  final Element filePicker = querySelector('#filepicker');
  final ButtonElement listDriveElement = querySelector('#listdrive'); 
  final ButtonElement createDriveFile = querySelector('#createdrive'); 
  var token = null;

  GoogleDriveManager(){
  }
  
  void authentification(auth) {
    this.drive = new drivelib.Drive(auth);
    this.drive.makeAuthRequests = true;
    filePicker.onChange.listen(ajouteFichier);
    listDriveElement.onClick.listen((e){
      _list(e);
    });
    createDriveFile.onClick.listen((e){
      _create(e);
    });
  }
  
  void login(token) {
    this.token = token;
    filePicker.style.display = "block";
    listDriveElement..disabled = false;
  }

  void logout() {
    this.token = null;
    filePicker.style.display = "none";
    output..innerHtml = "<b>drive deconnect</b>";
    listDriveElement..disabled = true;
  }

  void _create(Event evt) {
    //"C:\paysage.jpg"
    var contentType = 'application/octet-stream';
    //var uintlist = new Uint8List.fromList("test");
    //var charcodes = new String.fromCharCodes([68]);
    var charcodes = "Mon texte à afficher!!! ";
    var base64Data = window.btoa(charcodes);
    var newFile = new client.File.fromJson({"title": "monFichier.txt", "mimeType": contentType});
  //  output..appendHtml("Uploading file...<br>");
    drive.files.insert(newFile, content: base64Data, contentType: contentType)
      .then((data) {
        output..appendHtml("Uploaded file with ID <a href=\"${data.alternateLink}\" target=\"_blank\">${data.id}</a><br>");
      })
        .catchError((e) {
          output..appendHtml("$e<br>");
          return true;
        });

  }
  
  void ajouteFichier(Event evt) {
    //"C:\paysage.jpg"
    var file = (evt.target as InputElement).files[0];
    var reader = new FileReader();
    reader.readAsArrayBuffer(file);
    reader.onLoad.listen((Event e) {
      var contentType = file.type;
      contentType = 'application/octet-stream';
  
      var uintlist = new Uint8List.fromList(reader.result);
      var charcodes = new String.fromCharCodes(uintlist);
      var base64Data = window.btoa(charcodes);
      var newFile = new client.File.fromJson({"title": file.name, "mimeType": contentType});
      output..appendHtml("Uploading file...<br>");
      drive.files.insert(newFile, content: base64Data, contentType: contentType)
        .then((data) {
          output..appendHtml("Uploaded file with ID <a href=\"${data.alternateLink}\" target=\"_blank\">${data.id}</a><br>");
        })
          .catchError((e) {
            output..appendHtml("$e<br>");
            return true;
          });
  
      });
  }
  
  bool isLogged() {
    return token != null;
  }
  
  
  void _get(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      get_file(token, _fileId).then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }
  
  void _insert(e) {
    if(isLogged()) {
      insert_file(token, "New File Example").then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }
  
  void _delete(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      delete_file(token, _fileId, output).then((file){
        fileId.value = "";
        output.text = "Deleted File: $_fileId";
      });
    }
  }
  
  void _copy(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      copy_file(token, _fileId).then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }
  
  void _list(e){
    if(isLogged()) {
     // list_files(token, "mimeType = 'application/vnd.google-apps.document' AND trashed = false").then((fileList){
      list_files(token, "mimeType = 'application/octet-stream' AND trashed = false").then((fileList){
        output.innerHtml = '';
        fileId.value = '';
        fileList.items.forEach((client.File file){
          output.appendHtml("<div><a target='_blank' href='${file.alternateLink}'>${file.title}</a>: ${file.id}</div>");
        });
      });
    }
  }
  
  void _patch(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      patch_file(token, _fileId, "New File Example2").then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }
  
  void _touch(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      touch_file(token, _fileId).then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }
  
  void _trash(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      trash_file(token, _fileId).then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }
  
  void _untrash(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      untrash_file(token, _fileId).then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }
  
  void _update(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      update_file(token, _fileId,"All Work and No Play Makes Jack a dull boy.").then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }
  
}