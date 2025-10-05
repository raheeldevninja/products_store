import 'package:products_store/core/theme/domain/repositories/theme_repository.dart';
import 'package:products_store/core/theme/models/theme_mode_enum.dart';

class SetThemeMode {
  final ThemeRepository repository;

  SetThemeMode(this.repository);

  Future<void> call(AppThemeMode mode) async {
    return await repository.setThemeMode(mode);
  }
}