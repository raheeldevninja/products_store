import 'package:products_store/core/theme/data/theme_local_data_source.dart';
import 'package:products_store/core/theme/domain/repositories/theme_repository.dart';
import 'package:products_store/core/theme/models/theme_mode_enum.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl(this.localDataSource);

  @override
  Future<AppThemeMode> getThemeMode() async {
    return await localDataSource.getThemeMode();
  }

  @override
  Future<void> setThemeMode(AppThemeMode mode) async {
    await localDataSource.setThemeMode(mode);
  }
}