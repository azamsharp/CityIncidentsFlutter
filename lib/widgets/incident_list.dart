

import 'package:city_care/view_models/incident_view_model.dart';
import 'package:flutter/material.dart';

class IncidentList extends StatelessWidget {

  List<IncidentViewModel> incidents; 

  IncidentList(List<IncidentViewModel> incidents) {
    this.incidents = incidents; 
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: incidents.length,
      itemBuilder: (context, index) {
        
        final incident = incidents[index]; 

        return ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(incident.photoURL, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(incident.title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(incident.incidentDate, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, fontWeight: FontWeight.w400)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(incident.description),
              )
            ],
          ), 
        );
      },
    );
  }
}