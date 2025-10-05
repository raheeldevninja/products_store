import 'package:products_store/core/theme/models/theme_mode_enum.dart';

abstract class ThemeRepository {

  Future<AppThemeMode> getThemeMode();
  Future<void> setThemeMode(AppThemeMode mode);

}