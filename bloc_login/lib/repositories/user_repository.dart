import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future signInWithEmailAndPassword(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(), password: password);
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    await _firebaseAuth.signInWithCredential(authCredential);
  }

  Future createUserWithEmailAndPassword(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(), password: password);
  }

  Future signOut() async {
    return Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  Future<bool> isSignIn() async {
    return await _firebaseAuth.currentUser != null;
  }

  Future<User?> getUser() async {
    return await _firebaseAuth.currentUser;
  }
}
