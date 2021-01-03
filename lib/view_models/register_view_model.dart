import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel {
  final String email;
  final String password;

  RegisterViewModel({this.email, this.password});

  Future<bool> register() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential != null;
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }

    return false;
  }
}
