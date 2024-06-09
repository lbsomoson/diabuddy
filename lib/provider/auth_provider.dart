import 'package:diabuddy/api/auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
  }

  User? get user => authService.getUser();

  Future signInWithGoogle() async {
    return await authService.signInWithGoogle();
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }

  Future<bool> addUser(String id) async {
    return await authService.addUser(id);
  }
}
