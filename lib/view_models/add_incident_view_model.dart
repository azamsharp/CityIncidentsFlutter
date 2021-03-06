import 'dart:io';
import 'package:city_care/models/incident.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

enum LoadingState {
  idle, loading, success, failure 
}

class AddIncidentViewModel extends ChangeNotifier {
  
  String message = ""; 
  LoadingState loadingStatus = LoadingState.idle; 

  Future<bool> saveIncident(Incident incident) async {

    bool isSaved = false; 
    loadingStatus = LoadingState.loading; 
    notifyListeners(); 
    
    try {
       
       await FirebaseFirestore.instance
        .collection("incidents")
        .add(incident.toMap());
        
        isSaved = true; 
        loadingStatus = LoadingState.success; 

    } catch(e) {
      message = "Unable to save incident"; 
      loadingStatus = LoadingState.failure; 
    } 

    notifyListeners(); 
    return isSaved; 
  }

  Future<String> uploadFile(File file) async {
    String downloadURL;

    final uuid = Uuid();
    final filePath = "/images/${uuid.v4()}.jpg";
    final storage = FirebaseStorage.instance.ref(filePath);
    final uploadTask = await storage.putFile(file);

    if (uploadTask.state == TaskState.success) {
      // get the url for the file
      downloadURL =
          await FirebaseStorage.instance.ref(filePath).getDownloadURL();
    }

    return downloadURL;
  }
}
