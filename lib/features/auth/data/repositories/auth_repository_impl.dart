import 'package:products_store/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:products_store/features/auth/data/models/user_model.dart';
import 'package:products_store/features/auth/domain/entities/user.dart';
import 'package:products_store/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class AuthRepositoryImpl extends AuthRepository {

  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Stream<User?> get authStateChanges =>
      remote.authStateChanges.map((userModel) => userModel?.toEntity());

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await remote.signIn(email: email, password: password);
    final fb.User? fbUser = credential.user;

    if (fbUser == null) return null;

    final model = await remote.getUserModel(fbUser.uid);

    if (model != null) return model.toEntity();

    // fallback: build domain entity from Firebase user
    return User(
      uid: fbUser.uid,
      name: fbUser.displayName ?? '',
      email: fbUser.email ?? '',
    );
  }

  @override
  Future<User?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await remote.signUp(email: email, password: password);
    final fb.User? fbUser = credential.user;

    if (fbUser == null) return null;

    final userModel = UserModel(uid: fbUser.uid, name: name, email: email);
    await remote.createUserDocument(userModel);

    // update FirebaseAuth profile (optional but useful)
    await fbUser.updateDisplayName(name);
    await fbUser.reload();

    return userModel.toEntity();
  }

  @override
  Future<User?> getCurrentUser() async {
    final firebaseUser = remote.currentUser;

    if (firebaseUser == null) return null;

    final model = await remote.getUserModel(firebaseUser.uid);

    return model?.toEntity() ??
        User(
          uid: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
        );
  }

  @override
  Future<void> sendPasswordReset({required String email}) {
    return remote.sendPasswordReset(email: email);
  }

  @override
  Future<void> signOut() {
    return remote.signOut();
  }
}