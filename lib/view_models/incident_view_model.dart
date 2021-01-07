
import 'package:city_care/models/incident.dart';
import 'package:intl/intl.dart';

class IncidentViewModel {

  final Incident incident; 

  IncidentViewModel({this.incident});

  String get title {
    return incident.title; 
  }

  String get description {
    return incident.description; 
  }

  String get photoURL {
    return incident.photoURL; 
  }

  String get incidentDate {
    return DateFormat("MM-dd-yyyy HH:mm:ss").format(incident.incidentDate);
  }

}