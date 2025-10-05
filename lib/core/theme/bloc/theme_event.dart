import 'package:equatable/equatable.dart';
import 'package:products_store/core/theme/models/theme_mode_enum.dart';

abstract class ThemeEvent extends Equatable {

  const ThemeEvent();

  @override
  List<Object?> get props => [];

}

class LoadThemeEvent extends ThemeEvent {}

class ChangeThemeEvent extends ThemeEvent {
  final AppThemeMode mode;

  const ChangeThemeEvent(this.mode);

  @override
  List<Object?> get props => [mode];
}