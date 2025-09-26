import 'package:products_store/features/auth/domain/repositories/auth_repository.dart';

class SendPasswordReset {

  final AuthRepository repository;

  SendPasswordReset(this.repository);

  Future<void> call({required String email}) {
    return repository.sendPasswordReset(email: email);
  }

}