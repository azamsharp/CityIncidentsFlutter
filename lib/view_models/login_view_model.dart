import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  String message = "";

  Future<bool> login(String email, String password) async {
    print("login"); 
    bool isLoggedIn = false; 

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isLoggedIn = userCredential != null; 
    } on FirebaseAuthException catch (e) {
      message = e.code; 
      print(message); 
      notifyListeners();
    } catch (e) {
      // some generic exception
      notifyListeners();
    }
    return isLoggedIn;
  }
}
