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

  // TODO: Check if new account or not
  Future signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
        print("userid in auth api: ${user!.uid}");
        // check if user already exists in the database
        if (user != null) {
          final DocumentSnapshot userSnapshot =
              await db.collection('users').doc(user!.uid).get();

          if (!userSnapshot.exists) {
            // add user to the database
            await db
                .collection('users')
                .doc(user!.uid)
                .set({"email": user!.email});
            return "new";
          }
        }
        return "existing";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          return user;
        } else if (e.code == 'invalid-credential') {
          return e.message;
        }
      } catch (e) {
        // handle the error here
        return e.toString();
      }
    }
    return null;
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut(); // sign out google
      await FirebaseAuth.instance.signOut(); // sign out user to firebase
    } catch (e) {}
  }
}

class NoGoogleAccountChosenException implements Exception {
  const NoGoogleAccountChosenException();
}
