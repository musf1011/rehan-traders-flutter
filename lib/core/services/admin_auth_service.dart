import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Replace this with your actual admin email
  static const String _adminEmail = "famzycodeworks@gmail.com";

  Future<User?> loginAdmin(String email, String password) async {
    try {
      // 1. Authenticate with Firebase
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("*****login successful: ${result.user?.email}*****");

      User? user = result.user;

      // 2. Strict Check: If it's not the specific admin email, sign them out immediately
      if (user != null && user.email == _adminEmail) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isAdminLoggedIn', true);
        debugPrint(
          "*****Admin login successful: ${user.email} ${prefs.getBool('isAdminLoggedIn')}*****",
        );
        return user;
      } else {
        await _auth.signOut();
        throw 'Unauthorized: Only the site administrator can access this panel.';
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("*****FirebaseAuthException: ${e.code} - ${e.message}*****");
      throw e.message ?? "An error occurred during login.";
    } catch (e) {
      debugPrint("*****Unexpected error: $e*****");
      rethrow;
    }
  }

  // Check if admin is logged in
  Future<bool> isAdminLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAdminLoggedIn') ?? false;
  }

  // Logout admin
  Future<void> logoutAdmin() async {
    _auth.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isAdminLoggedIn');
  }

  // Future<void> logout() async {
  //   await _auth.signOut();
  // }
}
