import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/pages/login_page.dart';
import 'package:todo_list/pages/register_page.dart';
import 'package:todo_list/view_models/login_view_model.dart';
import 'package:todo_list/view_models/register_view_model.dart';

class IncidentListPage extends StatelessWidget {
  void _navigateToRegisterPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => RegisterViewModel(),
                child: RegisterPage()),
            fullscreenDialog: true));
  }

  void _navigateToLoginPage(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => LoginViewModel(), child: LoginPage()),
            fullscreenDialog: true));
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
