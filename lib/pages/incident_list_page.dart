import 'package:flutter/material.dart';
import 'package:city_care/extensions/navigator.dart';

class IncidentListPage extends StatelessWidget {

  void _navigateToRegisterPage(BuildContext context) async {
    final isRegistered = await AppNavigator.navigateToRegisterPage(context);
  }

  void _navigateToLoginPage(BuildContext context) async {
    final isLoggedIn = await AppNavigator.navigateToLoginPage(context);
    print(isLoggedIn); 
    if(!isLoggedIn) {
      AppNavigator.navigateToMyIncidentsPage(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(child: Text("Menu")),
            ListTile(title: Text("Home")),
            ListTile(
              title: Text("Add Incident"), 
              onTap: () {
                AppNavigator.navigateToAddIncidentsPage(context);
              },
            ),
            ListTile(
                title: Text("Login"),
                onTap: () {
                   _navigateToLoginPage(context);
                }),
            ListTile(
                title: Text("Register"),
                onTap: () {
                  _navigateToRegisterPage(context); 
                }),
            ListTile(title: Text("Add Incident"))
          ],
        )),
        appBar: AppBar(title: Text("Latest Incidents")));
  }
}
