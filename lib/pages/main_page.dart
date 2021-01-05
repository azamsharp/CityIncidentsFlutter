import 'package:city_care/extensions/navigator.dart';
import 'package:city_care/pages/incident_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override 
  _MainPage createState() => _MainPage(); 
}

class _MainPage extends State<MainPage> {

  String _title = "Latest Incidents"; 
  bool _isSignedIn = false; 

  @override
  void initState() {
    super.initState();
    _subscribeToFirebaseAuthChanges(); 
  }

  void _subscribeToFirebaseAuthChanges() {
    FirebaseAuth.instance
      .authStateChanges()
      .listen((user) {
        if(user == null) {
          // user is signed out 
          _isSignedIn = false; 
        } else {
          // user is signed in
          setState(() {
            _isSignedIn = true; 
          }); 
        }
       });
  }

  void _navigateToRegisterPage(BuildContext context) async {
    //final isRegistered = await AppNavigator.navigateToRegisterPage(context);
  }

  void _navigateToLoginPage(BuildContext context) async {
    final isLoggedIn = await AppNavigator.navigateToLoginPage(context);
    print(isLoggedIn);
    if (!isLoggedIn) {
      AppNavigator.navigateToMyIncidentsPage(context);
    }
  }

  void _navigateToAddIncidentsPage(BuildContext context) {
    AppNavigator.navigateToAddIncidentsPage(context); 
  }

  @override
  Widget build(BuildContext context) {

    final currentUser = FirebaseAuth.instance.currentUser; 

    return Scaffold(
        appBar: AppBar(title: Text(_title)),
        body: IncidentListPage(), 
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(child: Text("Menu")),
            ListTile(title: Text("Home")),
            _isSignedIn ? ListTile(
              title: Text("Add Incident"),
              onTap: () {
                _navigateToAddIncidentsPage(context); 
              },
            ) : SizedBox.shrink(),
            !_isSignedIn ? ListTile(
                title: Text("Login"),
                onTap: () {
                  _navigateToLoginPage(context);
                }) : SizedBox.shrink(),
            !_isSignedIn ? ListTile(
                title: Text("Register"),
                onTap: () {
                  _navigateToRegisterPage(context);
                }) : SizedBox.shrink(),
            _isSignedIn ? ListTile(
              title: Text("Logout"), 
              onTap: () async {
                // logout the user 
                await FirebaseAuth.instance.signOut(); 
              }
            ) : SizedBox.shrink()
          ],
        )),
        );
  }
}
