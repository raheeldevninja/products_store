import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:products_store/features/product/domain/entity/product.dart';

sealed class ProductsState extends Equatable {

  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoadInProgress extends ProductsState {}

class ProductsLoadSuccess extends ProductsState {
  final List<Product> products;
  final bool hasReachedMax;
  final DocumentSnapshot? lastDoc;

  const ProductsLoadSuccess({
    required this.products,
    required this.hasReachedMax,
    this.lastDoc,
  });

  ProductsLoadSuccess copyWith({
    List<Product>? products,
    bool? hasReachedMax,
    DocumentSnapshot? lastDoc,
  }) {
    return ProductsLoadSuccess(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      lastDoc: lastDoc ?? this.lastDoc,
    );
  }

  @override
  List<Object?> get props => [products, hasReachedMax, lastDoc];
}

class ProductsLoadFailure extends ProductsState {
  final String error;
  const ProductsLoadFailure(this.error);

  @override
  List<Object?> get props => [error];
}

