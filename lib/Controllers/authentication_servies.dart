import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection("users");
  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User?> get authStateChanges => _firebaseAuth.userChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
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

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
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
