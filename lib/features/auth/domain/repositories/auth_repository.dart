import 'package:products_store/features/auth/domain/entities/user.dart';

abstract class AuthRepository {

  Stream<User?> get authStateChanges;
  Future<User?> signIn({required String email, required String password});
  Future<User?> signUp({required String name, required String email, required String password});
  Future<void> sendPasswordReset({required String email});
  Future<void> signOut();
  Future<User?> getCurrentUser();

}
