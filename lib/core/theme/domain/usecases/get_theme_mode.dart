import 'package:products_store/core/theme/domain/repositories/theme_repository.dart';
import 'package:products_store/core/theme/models/theme_mode_enum.dart';

class GetThemeMode {
  final ThemeRepository repository;

  GetThemeMode(this.repository);

  Future<AppThemeMode> call() async {
    return await repository.getThemeMode();
  }
}