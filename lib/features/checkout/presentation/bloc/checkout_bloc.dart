import 'dart:async';

import 'package:products_store/features/checkout/checkouts.dart';


part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {

  final CreateCheckout createCheckout;
  final ConfirmCheckout confirmCheckout;
  final CancelCheckout cancelCheckout;
  final GetUserCheckouts getUserCheckouts;

  StreamSubscription<List<Checkout>>? _sub;

  CheckoutBloc({
    required this.createCheckout,
    required this.confirmCheckout,
    required this.cancelCheckout,
    required this.getUserCheckouts,
  }) : super(CheckoutInitial()) {
    on<CheckoutStarted>(_onStarted);
    on<CheckoutCreated>(_onCreated);
    on<CheckoutConfirmed>(_onConfirmed);
    on<CheckoutCancelled>(_onCancelled);
    on<CheckoutItemsUpdated>(_onCheckoutItemsUpdated);
  }

  Future<void> _onStarted(CheckoutStarted event, Emitter<CheckoutState> emit) async {

    emit(CheckoutLoadInProgress());

    await _sub?.cancel();

    _sub = getUserCheckouts(event.userId).listen((items) {

      add(CheckoutItemsUpdated(items));

    }, onError: (e) {
      emit(CheckoutFailure(e.toString()));
    });

  }

  _onCheckoutItemsUpdated(CheckoutItemsUpdated event, Emitter<CheckoutState> emit) {
    final items = event.items;
    emit(CheckoutLoadSuccess(items));
  }


  Future<void> _onCreated(CheckoutCreated event, Emitter<CheckoutState> emit) async {

    emit(CheckoutLoadInProgress());

    try {

      final checkout = await createCheckout(
        userId: event.userId,
        items: event.items,
        currency: event.currency,
      );

      emit(CheckoutOperationSuccess(checkout));

    } catch (e) {
      emit(CheckoutFailure(e.toString()));
    }
  }

  Future<void> _onConfirmed(
      CheckoutConfirmed event, Emitter<CheckoutState> emit) async {
    try {
      await confirmCheckout(event.checkoutId);
    } catch (e) {
      emit(CheckoutFailure(e.toString()));
    }
  }

  Future<void> _onCancelled(
      CheckoutCancelled event, Emitter<CheckoutState> emit) async {
    try {
      await cancelCheckout(event.checkoutId);
    } catch (e) {
      emit(CheckoutFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }

}
