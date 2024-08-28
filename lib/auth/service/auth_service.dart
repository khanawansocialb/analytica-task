import 'package:firebase_auth/firebase_auth.dart';

final class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> emailPasswordSignup(
      {required String email, required String password}) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    return user;
  }

  Future<User?> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    return user;
  }
}
