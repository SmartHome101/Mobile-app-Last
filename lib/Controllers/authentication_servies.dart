import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection("users");
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.userChanges();


  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }


  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return "error";
    }
  }


  Future<String> signUp(
      {required String email,
      required String password,
      required fullName,
      required code,
      required photoURL}) async {
    try {
      DatabaseEvent event = await ref.once();

      var homesList = event.snapshot.value as Map;
      var homes = homesList.keys.toList();
      var found = false;

      for (var home in homes) {
        if (home == code) found = true;
      }
      if (found == false) return "Invalid Code";

      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      await user!.updateDisplayName(fullName);
      await user.updatePhotoURL("icons/vector.png");

      await users.doc(user.uid).set({
        "email": email,
        "code": code,
        "uid": user.uid,
      });

      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return "error";
    }
  }

  Future<String> updateUser(
      {required String fullName, required String photoURL}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.updateDisplayName(fullName);
      await user?.updatePhotoURL(photoURL);
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return "error";
    }
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
