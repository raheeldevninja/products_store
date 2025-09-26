import 'package:equatable/equatable.dart';

sealed class ProductsEvent extends Equatable {

  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class ProductsFetched extends ProductsEvent {

  final bool isRefresh;
  const ProductsFetched({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}

