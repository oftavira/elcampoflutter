import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  // The class FirebaseService provides use to the authentication service and
  // the database service from Firebase
  //
  FirebaseAuth firebaseAuth;
  FirebaseFirestore db;
  bool adminView;
  FirebaseService([this.firebaseAuth, this.db, this.adminView]) {
    this.firebaseAuth ??= FirebaseAuth.instance;
    this.db ??= FirebaseFirestore.instance;
    this.adminView ??= false;
  }

  Stream<User> get auStChanges => this.firebaseAuth.authStateChanges();

  Future<String> signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'signed-in';
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String> testing(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Signed In';
    } catch (e) {
      return 'Not signed';
    }
  }

  Future<String> signOut() async {
    try {
      await this.firebaseAuth.signOut();
      return 'SignedOut';
    } on FirebaseAuthException catch (e) {
      print(e);
      return 'An error ocurred';
    }
  }

  void adminVal(val) {
    this.adminView = val;
  }

  FirebaseFirestore get dataBase => this.db;
  String get email => this.firebaseAuth.currentUser.email;
}
