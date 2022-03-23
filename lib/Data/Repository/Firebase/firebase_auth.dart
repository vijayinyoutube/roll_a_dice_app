import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication {
  Future<bool> signUp(String emailID, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailID, password: password);
      debugPrint("Logged in successfully!");
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      debugPrint("Logged out successfully!");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> isSignedIn() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null;
  }

  Future<String?> getUser() async {
    return FirebaseAuth.instance.currentUser!.email;
  }
}
