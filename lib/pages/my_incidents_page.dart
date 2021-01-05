

import 'package:city_care/extensions/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyIncidentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("My Incidents"), 
        actions: [
          FlatButton(
            child: Text("Add Incident"),
            textColor: Colors.white,
            onPressed: () {
              AppNavigator.navigateToAddIncidentsPage(context); 
            },
          )
        ]
      ), 
      body: Column(children: [
        Text("Incidents")
      ])
    );
    
  }
}