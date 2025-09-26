import 'package:products_store/features/product/products.dart';

part 'products_event.dart';
part 'products_state.dart';


class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {

  final GetProducts getProducts;

  static const int _pageSize = 6;
  bool _isFetching = false;

  ProductsBloc({required this.getProducts}) : super(ProductsInitial()) {
    on<ProductsFetched>(_onProductsFetched);
  }

  Future<void> _onProductsFetched(ProductsFetched event, Emitter<ProductsState> emit) async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      if (event.isRefresh || state is ProductsInitial) {

        emit(ProductsLoadInProgress());

        final page = await getProducts(
          pageSize: _pageSize,
          startAfter: null,
        );

        emit(ProductsLoadSuccess(products: page.products, hasReachedMax: !page.hasMore, lastDoc: page.lastDoc,));

      } else if (state is ProductsLoadSuccess) {

        final current = state as ProductsLoadSuccess;

        if (current.hasReachedMax) return;

        final page = await getProducts(
          pageSize: _pageSize,
          startAfter: current.lastDoc,
        );

        final updated = List<Product>.from(current.products)
          ..addAll(page.products);

        emit(current.copyWith(
          products: updated,
          hasReachedMax: !page.hasMore,
          lastDoc: page.lastDoc,
        ));
      }
    } catch (e) {
      emit(ProductsLoadFailure(e.toString()));
    } finally {
      _isFetching = false;
    }
  }

}