import 'package:diabuddy/api/auth_api.dart';
import 'package:diabuddy/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
  }

  User? get user => authService.getUser();
  AppUser? _userInfo;
  AppUser? get userInfo => _userInfo;

  Future<void> getUserInfo(String id) async {
    _userInfo = await authService.getUserInfo(id);
    notifyListeners();
  }

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

  Future<bool> editUser(String id, int age, double height, double weight, String activityLevel) async {
    var edit = await authService.editUser(id, age, height, weight, activityLevel);
    notifyListeners();
    return edit;
  }

  Future<void> onboarding(String id, AppUser appuser) async {
    return await authService.onboarding(id, appuser);
  }
}
