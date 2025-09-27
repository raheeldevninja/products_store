import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:products_store/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSource({FirebaseAuth? auth, FirebaseFirestore? firestore})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<UserModel?> get authStateChanges {
    return _auth.authStateChanges().asyncMap((user) async {

      if (user == null) return null;

      // Always check FireStore first
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }

      // fallback if FireStore doc missing
      return UserModel(
        uid: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
      );
    });
  }

  Future<UserCredential> signIn({required String email, required String password}) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signUp({required String email, required String password}) {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> sendPasswordReset({required String email}) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  Future<void> createUserDocument(UserModel user) {
    return _firestore.collection('users').doc(user.uid).set(user.toDocument());
  }

  Future<UserModel?> getUserModel(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc);
  }

}