import 'package:flutter/material.dart';
import 'package:products_store/core/theme/models/theme_mode_enum.dart';

class ThemeState {
  final ThemeMode themeMode;
  final AppThemeMode appThemeMode;

  ThemeState({required this.themeMode, required this.appThemeMode});

  factory ThemeState.initial() {
    return ThemeState(themeMode: ThemeMode.system, appThemeMode: AppThemeMode.system);
  }
}