import 'package:flutter/material.dart';
import 'package:products_store/core/theme/bloc/theme_event.dart';
import 'package:products_store/core/theme/bloc/theme_state.dart';
import 'package:products_store/core/theme/domain/usecases/get_theme_mode.dart';
import 'package:products_store/core/theme/domain/usecases/set_theme_mode.dart';
import 'package:products_store/core/theme/models/theme_mode_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeMode getThemeModeUseCase;
  final SetThemeMode setThemeModeUseCase;

  ThemeBloc(this.getThemeModeUseCase, this.setThemeModeUseCase)
      : super(ThemeState.initial()) {
    on<LoadThemeEvent>(_onLoadTheme);
    on<ChangeThemeEvent>(_onChangeTheme);
  }

  Future<void> _onLoadTheme(LoadThemeEvent event, Emitter<ThemeState> emit) async {
    final appThemeMode = await getThemeModeUseCase();
    emit(ThemeState(
      themeMode: _mapToFlutterThemeMode(appThemeMode),
      appThemeMode: appThemeMode,
    ));
  }

  Future<void> _onChangeTheme(ChangeThemeEvent event, Emitter<ThemeState> emit) async {
    await setThemeModeUseCase(event.mode);
    emit(ThemeState(
      themeMode: _mapToFlutterThemeMode(event.mode),
      appThemeMode: event.mode,
    ));
  }

  ThemeMode _mapToFlutterThemeMode(AppThemeMode mode) {

    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }

  }

}