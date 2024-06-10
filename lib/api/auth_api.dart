import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  User? user;

  // get the currently logged user
  User? getUser() {
    return auth.currentUser;
  }

  static Stream<User?> get userStream => auth.authStateChanges();

  Future<bool> addUser(String id) async {
    // Check if the user exists in Firestore
    final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await db.collection('users').doc(id).get();

    if (!userSnapshot.exists) {
      // if the user doesn't exist, add the user to Firestore
      await db.collection('users').doc(id).set({
        'userId': id,
      });
      return true;
    }
    return false;
  }

  // TODO: Check if new account or not
  Future signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    print("==========================$googleSignInAccount");

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      print(credential);

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        print(userCredential.user);
        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print(e.message);
          return e.message;
        } else if (e.code == 'invalid-credential') {
          print(e.message);
          return e.message;
        }
      } catch (e) {
        print(e);
        // handle the error here
        return e.toString();
      }
    }
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut(); // sign out google
      await FirebaseAuth.instance.signOut(); // sign out user to firebase
    } catch (e) {
      print(e);
    }
  }
}

class NoGoogleAccountChosenException implements Exception {
  const NoGoogleAccountChosenException();
}
