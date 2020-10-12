import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authorization {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  ///Handles registering with e-mail & password.
  Future registerWithEmail(String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  ///Handles signing in with e-mail & password.
  Future signInWithEmail(String email, String password) async {
    try {
      return (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  ///Handles regular signing out.
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      final googleSignInAuth = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuth.idToken,
        accessToken: googleSignInAuth.accessToken,
      );
      return (await _firebaseAuth.signInWithCredential(credential)).user;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  ///Handles Google signing out.
  Future signOutGoogle() async {
    try {
      return await _googleSignIn.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}

final Authorization authorization = Authorization();
