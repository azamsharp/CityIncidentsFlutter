



import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel {

  final String email; 
  final String password; 

  RegisterViewModel({this.email, this.password});

  void register() async {
    
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      print(e); 
    } catch(e) {
      print(e);
    }
    
    
  }

}