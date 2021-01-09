import 'package:firebase_auth/firebase_auth.dart';
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

  Future<String> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      final googleSignInAuth = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuth.idToken,
        accessToken: googleSignInAuth.accessToken,
      );
      return await _firebaseAuth
          .signInWithCredential(credential)
          .then((_) => googleSignInAccount.displayName);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  ///Handles signing out.
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

  Future<void> updateUserProfile({
    email,
    password,
    displayName,
  }) async {
    try {
      if (email != null) return await getCurrentUser().updateEmail(email);
      if (password != null)
        return await getCurrentUser().updatePassword(password);
      if (displayName != null) {
        return await getCurrentUser()
            .updateProfile(displayName: displayName);
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}
