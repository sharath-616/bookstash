import 'package:firebase_auth/firebase_auth.dart';

class AuthClassHelper {
  static Future<String> createAccountWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return "Account Created ..!";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  //login...

  static Future<String> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return "Login Seccess..!";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  //logout...

  static Future logout() async {
    try {
      return FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  //Check User is login

  static Future<bool> isUserLoggedin ()async {
    var currentuser = FirebaseAuth.instance.currentUser;
    return currentuser != null ? true : false;
  }
}
