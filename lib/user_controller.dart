import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_authn_task/user_model.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> login(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signup(
    String name,
    String email,
    String password,
  ) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
      });
    }
    return result;
  }

  Future<UserModel?> getUserData() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists || doc.data() == null) {
      print("No user document found for UID: $uid");
      return null;
    }
    return UserModel.fromMap(doc.data()!);
  }

  Future<void> logout() => _auth.signOut();
}
