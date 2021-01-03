import 'package:flutter/material.dart';
import 'package:todo_list/utils/constants.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CircleAvatar(
                      maxRadius: 150,
                      backgroundImage:
                          AssetImage(Constants.LOGIN_PAGE_HERO_IMAGE)),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Email is required!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Password is required!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  FlatButton(
                      child:
                          Text("Login", style: TextStyle(color: Colors.white)),
                      onPressed: () {},
                      color: Colors.blue)
                ],
              )),
        ));
  }
}
