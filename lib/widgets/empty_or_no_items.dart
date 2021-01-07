

import 'package:flutter/material.dart';

class EmptyOrNoItems extends StatelessWidget {

  final String message; 

  EmptyOrNoItems({this.message = ""});

  @override
  Widget build(BuildContext context) {
    return Text(message, style: TextStyle(fontSize: 18));
  }
} 