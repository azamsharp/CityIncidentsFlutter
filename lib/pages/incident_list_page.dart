import 'package:city_care/view_models/incident_list_view_model.dart';
import 'package:city_care/view_models/incident_view_model.dart';
import 'package:city_care/widgets/incident_list.dart';
import 'package:flutter/material.dart';


class IncidentListPage extends StatefulWidget {
  @override 
  _IncidentListPage createState() => _IncidentListPage(); 
}

class _IncidentListPage extends State<IncidentListPage> {

  IncidentListViewModel _incidentListVM = IncidentListViewModel(); 
  List<IncidentViewModel> _incidents = List<IncidentViewModel>(); 

  @override
  void initState() {
    super.initState();
    _populateAllIncidents(); 
  }

  void _populateAllIncidents() async {
    
    final incidents = await _incidentListVM.getAllIncidents();
    setState(() {
      _incidents = incidents; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: IncidentList(_incidents),
          ),
        )
      );
  }
}
