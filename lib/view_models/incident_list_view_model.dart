

import 'package:city_care/models/incident.dart';
import 'package:city_care/view_models/incident_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IncidentListViewModel {

  Future<List<IncidentViewModel>> getAllIncidents() async {
   
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("incidents").get();
    final incidents = snapshot.docs.map((doc) => Incident.fromDocument(doc)).toList();
    return  incidents.map((incident) => IncidentViewModel(incident: incident)).toList();
    
  }

}