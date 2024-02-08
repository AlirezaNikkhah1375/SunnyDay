import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:no_more_waste/widgets/common/toast.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "INVALID_LOGIN_CREDENTIALS":
          showToast(message: "Your email address or password is wrong.");
          break;
        default:
          log('${error.message}');
          showToast(message: '${error.message}');
      }
    }
    return null;
  }

  void signOut() {
    _auth.signOut();
    showToast(message: "Successfully signed out");
  }
}
