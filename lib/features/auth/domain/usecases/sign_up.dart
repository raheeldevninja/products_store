import 'package:products_store/features/auth/domain/entities/user.dart';
import 'package:products_store/features/auth/domain/repositories/auth_repository.dart';

class SignUp {

  final AuthRepository repository;

  SignUp(this.repository);

  Future<User?> call({required String name, required String email, required String password}) {
    return repository.signUp(name: name, email: email, password: password);
  }
}