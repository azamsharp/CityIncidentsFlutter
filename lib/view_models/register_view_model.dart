import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/utils/constants.dart';

class RegisterViewModel extends ChangeNotifier {
  final String email;
  final String password;
  String message = "";

  RegisterViewModel({this.email, this.password});

  Future<bool> register() async {

    bool isRegistered = false; 

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      isRegistered = userCredential != null;

    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        message = Constants.WEAK_PASSWORD;
      } else if (e.code == "email-already-in-use") {
        message = Constants.EMAIL_ALREADY_IN_USE;
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }

    return isRegistered;
  }
}
