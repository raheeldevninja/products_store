import 'package:products_store/features/auth/domain/repositories/auth_repository.dart';

class ChangePassword {
  final AuthRepository repository;

  ChangePassword(this.repository);

  Future<void> call(String currentPassword, String newPassword) async {
    return repository.changePassword(currentPassword: currentPassword, newPassword: newPassword);
  }
}