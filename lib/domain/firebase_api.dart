import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> googleSign() async {
    final response = await GoogleSignIn().signIn();

    return false;
  }
}
