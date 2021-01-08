import 'package:city_care/extensions/navigator.dart';
import 'package:city_care/pages/login_page.dart';
import 'package:city_care/view_models/incident_list_view_model.dart';
import 'package:city_care/view_models/incident_view_model.dart';
import 'package:city_care/view_models/login_view_model.dart';
import 'package:city_care/widgets/empty_or_no_items.dart';
import 'package:city_care/widgets/incident_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncidentListPage extends StatefulWidget {
  @override
  _IncidentListPage createState() => _IncidentListPage();
}

class _IncidentListPage extends State<IncidentListPage> {
  
  IncidentListViewModel _incidentListVM = IncidentListViewModel();
  List<IncidentViewModel> _incidents = List<IncidentViewModel>();

  bool _isSignedIn = false; 

  @override
  void initState() {
    super.initState();
    _subscribeToFirebaseAuthChanges(); 
    _populateAllIncidents();
  }

  void _populateAllIncidents() async {
    final incidents = await _incidentListVM.getAllIncidents();
    setState(() {
      _incidents = incidents;
    });
  }

  void _subscribeToFirebaseAuthChanges() {
    FirebaseAuth.instance
      .authStateChanges()
      .listen((user) {
        if(user == null) {
          // user is signed out 
          setState(() {
            _isSignedIn = false; 
          });
        } else {
          // user is signed in
          setState(() {
            _isSignedIn = true; 
          }); 
        }
       });
  }

  void _navigateToRegisterPage(BuildContext context) async {
    final bool isRegistered = await AppNavigator.navigateToRegisterPage(context); 
    if(isRegistered) {
      AppNavigator.navigateToLoginPage(context); 
    }
  }

  void _navigateToLoginPage(BuildContext context) async {

    final bool isLoggedIn = await AppNavigator.navigateToLoginPage(context);
    if (isLoggedIn) {
      AppNavigator.navigateToMyIncidentsPage(context);
    } 
  }

  void _navigateToAddIncidentsPage(BuildContext context) async {
    bool incidentAdded = await AppNavigator.navigateToAddIncidentsPage(context); 
    if(incidentAdded) {
      _populateAllIncidents(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Latest Incidents")),
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(child: Text("Menu")),
            ListTile(title: Text("Home")),
            _isSignedIn
                ? ListTile(
                    title: Text("My Incidents"),
                    onTap: () async {
                        AppNavigator.navigateToMyIncidentsPage(context); 
                    })
                : SizedBox.shrink(),
            _isSignedIn
                ? ListTile(
                    title: Text("Add Incident"),
                    onTap: () {
                      _navigateToAddIncidentsPage(context);
                    },
                  )
                : SizedBox.shrink(),
            !_isSignedIn
                ? ListTile(
                    title: Text("Login"),
                    onTap: () {
                      _navigateToLoginPage(context);
                    })
                : SizedBox.shrink(),
            !_isSignedIn
                ? ListTile(
                    title: Text("Register"),
                    onTap: () {
                      _navigateToRegisterPage(context);
                    })
                : SizedBox.shrink(),
            _isSignedIn
                ? ListTile(
                    title: Text("Logout"),
                    onTap: () async {
                      // logout the user
                      await FirebaseAuth.instance.signOut();
                    })
                : SizedBox.shrink(), 
             
          ],
        )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _incidents.length > 0 ? IncidentList(_incidents) : EmptyOrNoItems(message: "No incidents found."),
          ),
        ));
  }
}
