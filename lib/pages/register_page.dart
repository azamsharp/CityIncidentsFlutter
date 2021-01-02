import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list/view_models/register_view_model.dart';


class RegisterPage extends StatelessWidget {
  
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(); 
  final _passwordController = TextEditingController(); 
  RegisterViewModel _registerVM; 

  void _registerUser() {
    if(_formKey.currentState.validate()) {

      final email = _emailController.text; 
      final password = _emailController.text;

      _registerVM = RegisterViewModel(email: email, password: password);
      _registerVM.register(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Register")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey, 
            child: Column(
            children: [

              Image(image: AssetImage("assets/images/city_care.jpg")),

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
                child: Text("Register", style: TextStyle(color: Colors.white)), 
                onPressed: _registerUser,
                color: Colors.blue  
              )
            ],
          )),
        ));
  }
}
