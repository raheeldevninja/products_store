import 'package:products_store/features/cart/cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItems getCartItems;
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final UpdateCartQuantity updateCartQuantity;
  final GetCartTotal getCartTotal;

  StreamSubscription<List<CartItem>>? _sub;

  CartBloc({
    required this.getCartItems,
    required this.addToCart,
    required this.removeFromCart,
    required this.updateCartQuantity,
    required this.getCartTotal,
  }) : super(CartInitial()) {
    on<CartStarted>(_onStarted);
    on<CartAddRequested>(_onAddRequested);
    on<CartRemoveRequested>(_onRemoveRequested);
    on<CartQuantityUpdated>(_onQuantityUpdated);
    on<CartCleared>(_onCleared);
    on<CartItemsUpdated>(_onItemsUpdated);
  }

  Future<void> _onStarted(CartStarted event, Emitter<CartState> emit) async {

    emit(CartLoadInProgress());

    await _sub?.cancel();

    _sub = getCartItems(event.userId).listen((items) {
      add(CartItemsUpdated(items));
    }, onError: (e) {
      add(CartItemsUpdatedError(e.toString()));
    });
  }

  Future<void> _onItemsUpdated(CartItemsUpdated event, Emitter<CartState> emit) async {
    final items = event.items;
    final total = items.fold<double>(0, (prev, e) => prev + e.price * e.quantity);
    final outOfStock = items.any((i) => i.quantity <= 0); // you can implement more checks
    emit(CartLoadSuccess(items: items, total: total, outOfStock: outOfStock));
  }

  Future<void> _onAddRequested(
      CartAddRequested event,
      Emitter<CartState> emit,
      ) async {

    if (state is CartLoadSuccess) {

      final currentState = state as CartLoadSuccess;

      // Optimistic item
      final optimisticItem = CartItem(
        id: "temp-${event.productId}", // temporary ID, replaced later by FireStore
        productId: event.productId,
        name: event.name,
        price: event.price,
        currency: event.currency,
        imageUrl: event.imageUrl,
        quantity: event.quantity,
        addedAt: DateTime.now(),
        isUpdating: true,
      );

      // Optimistically update state
      final updatedItems = List<CartItem>.from(currentState.items)..add(optimisticItem);

      final total = updatedItems.fold<double>(
        0,
            (prev, e) => prev + e.price * e.quantity,
      );

      emit(currentState.copyWith(items: updatedItems, total: total));

      try {

        // Background FireStore sync
        await addToCart.call(
          userId: event.userId,
          productId: event.productId,
          quantity: event.quantity,
        );

        // FireStore will later stream the real cart item (with correct id)
        // via getCartItems subscription -> UI updates automatically

      } catch (e) {

        // Rollback: remove the temp item
        final rollbackItems = currentState.items;
        emit(CartOperationFailure(message: e.toString()));
        emit(currentState.copyWith(items: rollbackItems, total: currentState.total));

      }
    }

  }

  Future<void> _onRemoveRequested(
      CartRemoveRequested event,
      Emitter<CartState> emit,
      ) async {

    if (state is CartLoadSuccess) {

      final currentState = state as CartLoadSuccess;

      // Optimistic update
      final updatedItems = currentState.items
          .where((i) => i.id != event.cartItemId)
          .toList();

      final total = updatedItems.fold<double>(
        0,
            (prev, e) => prev + e.price * e.quantity,
      );

      emit(currentState.copyWith(items: updatedItems, total: total));

      try {

        // FireStore sync
        await removeFromCart.call(
          userId: event.userId,
          cartItemId: event.cartItemId,
        );
      } catch (e) {

        // Rollback -> remove the isUpdating flag
        final rollbackItems = currentState.items.map((i) {
          if (i.id == event.cartItemId) {
            return i.copyWith(isUpdating: false);
          }
          return i;
        }).toList();

        emit(CartOperationFailure(message: e.toString()));
        emit(currentState.copyWith(items: rollbackItems));

      }
    }
  }

  Future<void> _onQuantityUpdated(
      CartQuantityUpdated event,
      Emitter<CartState> emit,
      ) async {

    if (state is CartLoadSuccess) {

      final currentState = state as CartLoadSuccess;

      // Optimistic update
      final updatedItems = currentState.items.map((i) {

        if (i.id == event.cartItemId) {
          return i.copyWith(quantity: event.newQuantity, isUpdating: true,);
        }

        return i;

      }).toList();

      final total = updatedItems.fold<double>(
        0,
            (prev, e) => prev + e.price * e.quantity,
      );

      emit(currentState.copyWith(items: updatedItems, total: total));

      try {
        // FireStore sync
        await updateCartQuantity.call(
          userId: event.userId,
          cartItemId: event.cartItemId,
          quantity: event.newQuantity,
        );
      } catch (e) {

        // Rollback: reset isUpdating + restore old qty
        final rollbackItems = currentState.items.map((i) {
          if (i.id == event.cartItemId) {
            return i.copyWith(isUpdating: false); // restore qty from old state
          }
          return i;
        }).toList();

        emit(CartOperationFailure(message: e.toString()));
        emit(currentState.copyWith(items: rollbackItems, total: currentState.total));

      }
    }

  }

  Future<void> _onCleared(CartCleared event, Emitter<CartState> emit) async {
    await _sub?.cancel();
    emit(CartLoadSuccess(items: [], total: 0));
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
