import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Model/user_model.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ------------------ SIGN UP ------------------//

  Future<String> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      // 1️⃣ Create account in Firebase Auth
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2️⃣ Create UserModel
      UserModel newUser = UserModel(
        userId: cred.user!.uid,
        username: username,
        email: email,
        photoUrl: "https://example.com/default_profile.png",
      );

      // 3️⃣ Save to Firestore
      try {
        await _firestore.collection("users").doc(cred.user!.uid).set(newUser.toMap());
        print("Firestore write SUCCESS");
      } catch (e) {
        print("Firestore write ERROR: $e");
      }

      print("SIGN UP SUCCESS"); // debug line
      return "Success";

    } on FirebaseAuthException catch (e) {
      print("AUTH ERROR: ${e.message}");
      return e.message ?? "Signup failed";
    } catch (e) {
      print("GENERIC ERROR: $e"); // <-- This will catch Firestore or other issues
      return e.toString();
    }
  }


  // ------------------ LOGIN ------------------//
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Login failed";
    }
  }
  Future<void> fullLogout() async {
    try {
      await GoogleSignIn().signOut();
    } catch (_) {}
    await FirebaseAuth.instance.signOut();
  }


  /// ------------------ GOOGLE SIGN IN ------------------
  Future<String> signInWithGoogle() async {
    try {
      // Step 1: Google popup
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return "Cancelled";

      // Step 2: Google Auth details
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Step 3: Firebase credentials
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential cred =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Step 4: Save to Firestore (only once)
      DocumentSnapshot snap =
      await _firestore.collection("users").doc(cred.user!.uid).get();

      if (!snap.exists) {
        UserModel user = UserModel(
          userId: cred.user!.uid,
          username: cred.user!.displayName ?? "No Name",
          email: cred.user!.email ?? "",
          photoUrl: cred.user!.photoURL,
        );

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toMap());
      }

      return "Success";
    } catch (e) {
      print("Google sign-in ERROR: $e");
      return "Google login failed";
    }

  }

  /// ------------------ SIGN OUT ------------------
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}


