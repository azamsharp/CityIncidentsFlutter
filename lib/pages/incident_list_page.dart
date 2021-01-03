import 'package:flutter/material.dart';
import 'package:todo_list/pages/login_page.dart';
import 'package:todo_list/pages/register_page.dart';

class IncidentListPage extends StatelessWidget {
  void _navigateToRegisterPage(BuildContext context) async {
    bool isRegistered = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterPage(), fullscreenDialog: true));
  }

  void _navigateToLoginPage(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(), fullscreenDialog: true));
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
