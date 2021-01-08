

import 'package:city_care/models/incident.dart';
import 'package:city_care/view_models/incident_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyIncidentsViewModel {

   Future<List<IncidentViewModel>> getMyIncidents() async {

    final userId = FirebaseAuth.instance.currentUser.uid; 

    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("incidents")
    .where("userId", isEqualTo: userId)
    .orderBy("incidentDate", descending: true)
    .get();
    final incidents = snapshot.docs.map((doc) => Incident.fromDocument(doc)).toList();
    return  incidents.map((incident) => IncidentViewModel(incident: incident)).toList();

  }

}