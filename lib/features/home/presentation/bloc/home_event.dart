part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class TabChangedEvent extends HomeEvent {
  final int index;

  const TabChangedEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

