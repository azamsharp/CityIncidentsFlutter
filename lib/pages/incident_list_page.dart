

import 'package:flutter/material.dart';
import 'package:todo_list/pages/register_page.dart';

class IncidentListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text("Menu")
            ), 
            ListTile(
              title: Text("Home")
            ), 
            ListTile(
              title: Text("Login")
            ), 
            ListTile(
              title: Text("Register"), 
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(), fullscreenDialog: true));
              }
            ), 
            ListTile(
              title: Text("Add Incident")
            )
          ],
        )
      ),
      appBar: AppBar(
        title: Text("Latest Incidents")
      )
    );
    
  }

}