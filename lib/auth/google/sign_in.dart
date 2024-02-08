import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:no_more_waste/widgets/common/toast.dart';

const List<String> scopes = <String>[
  'email',
  'profile',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // ! FIX : fix clientID in plist.info : it does not work
  clientId:
      '137490242625-f9qd7q6n40jek6rs76hrbommcs3d4li3.apps.googleusercontent.com',
  scopes: scopes,
);

Future<dynamic> signInWithGoogle() async {
  try {
    // Google email and profile data
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return FirebaseAuth.instance.signInWithCredential(credential);
  } on Exception catch (e) {
    log('exception -> $e');
    showToast(message: 'Something went wrong...');
  }
}
