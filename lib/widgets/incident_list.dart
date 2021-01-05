

import 'package:city_care/view_models/incident_list_view_model.dart';
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
          title: Text(incident.title, style: TextStyle(fontWeight: FontWeight.w500)), 
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(incident.description)
          ),
        );
      },
    );
  }
}