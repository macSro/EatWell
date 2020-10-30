import 'package:eat_well_v1/model/diet.dart';
import 'package:eat_well_v1/model/user.dart' as LocalUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  FirebaseAuth _firebaseAuth;
  GoogleSignIn _googleSignIn;

  UserRepository() {
    _firebaseAuth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
  }

  User getCurrentUser() => _firebaseAuth.currentUser;

  ///Handles registering with e-mail & password.
  Future<UserCredential> registerWithEmail(
    String email,
    String password,
  ) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  ///Handles signing in with e-mail & password.
  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  ///Handles regular signing out.
  Future<bool> signOut() async {
    try {
      return await _firebaseAuth.signOut().then(
            (_) async => await _googleSignIn.signOut().then((value) => true),
          );
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      final googleSignInAuth = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuth.idToken,
        accessToken: googleSignInAuth.accessToken,
      );
      return await _firebaseAuth.signInWithCredential(credential);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  LocalUser.User createUserFromFirebase({
    @required User firebaseUser,
    @required String displayName,
  }) {
    return LocalUser.User(
      id: firebaseUser.uid,
      displayName: displayName,
      diet: Diet(),
    );
  }

  Future<void> updateUserProfile({
    @required localUser,
    email,
    password,
    displayName,
    diet,
  }) async {
    //if(email != null)
  }
}
