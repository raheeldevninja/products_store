import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_store/core/extension/context.dart';
import 'package:products_store/core/ui/widgets/app_button.dart';
import 'package:products_store/core/ui/widgets/base_app_bar.dart';
import 'package:products_store/core/ui/widgets/empty_layout.dart';
import 'package:products_store/core/ui/widgets/loading_indicator.dart';
import 'package:products_store/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:products_store/features/cart/cart.dart';
import 'package:products_store/features/cart/presentation/widgets/cart_item_tile.dart';
import 'package:products_store/features/checkout/domain/entities/checkout.dart';
import 'package:products_store/features/checkout/presentation/bloc/checkout_bloc.dart';

class CartPage extends StatefulWidget {

  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  late CartBloc _cartBloc;

  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;
    final userId = (authState is AuthAuthenticated) ? authState.user.uid : null;

    _cartBloc = context.read<CartBloc>();
    _cartBloc.add(CartStarted(userId ?? ''));
  }

  @override
  Widget build(BuildContext context) {

    final authState = context.watch<AuthBloc>().state;
    final userId = (authState is AuthAuthenticated) ? authState.user.uid : null;

    return Scaffold(
      appBar: BaseAppBar(title: 'Cart'),
      body: BlocListener<CheckoutBloc, CheckoutState>(
        listener: (context, state) {

          if(state is CheckoutFailure) {
            context.showSnackBarMessage(context, message: state.message);
          }

          if(state is CheckoutOperationSuccess) {

            final authState = context.read<AuthBloc>().state;
            final userId = (authState is AuthAuthenticated) ? authState.user.uid : null;

            if (userId != null) {
              context.read<CartBloc>().add(CartItemsCleared(userId));
            }

            context.showSnackBarMessage(context, message: "Checkout successful!", contentType: ContentType.success);

            // Navigate to checkout page
            context.push('/checkout');
          }

        },
        child: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {

            if (state is CartOperationFailure) {
              context.showSnackBarMessage(context, message: state.message);
            }

          },
          builder: (context, state) {

            if (state is CartLoadInProgress || state is CartInitial) {
              return LoadingIndicator();
            }
            else if (state is CartLoadSuccess) {

              if (state.items.isEmpty) {
                return EmptyLayout('Your cart is empty');
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.items.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = state.items[index];

                        return CartItemTile(
                          item: item,
                          isUpdating: item.isUpdating,
                          onRemove: () {
                            _cartBloc.add(CartRemoveRequested(userId: userId ?? '', cartItemId: item.id));
                          },
                          onQuantityChanged: (newQty) {
                            _cartBloc.add(CartQuantityUpdated(userId: userId ?? '', cartItemId: item.id, newQuantity: newQty));
                          },
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: context.textTheme.titleLarge),
                            Text('\$${state.total.toStringAsFixed(2)}', style: context.textTheme.bodyLarge!.copyWith(fontSize: 18)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        BlocBuilder<CheckoutBloc, CheckoutState>(
                          builder: (context, checkoutState) {

                            return AppButton(
                              isLoading: checkoutState is CheckoutLoadInProgress,
                              onPressed: state.outOfStock ? null : () {

                                // handle checkout
                                if (userId == null) return;

                                // Convert CartItem → CheckoutItem
                                final items = state.items.map((item) => CheckoutItem(
                                  productId: item.productId,
                                  name: item.name,
                                  price: item.price,
                                  quantity: item.quantity,
                                  imageUrl: item.imageUrl,
                                )).toList();

                                context.read<CheckoutBloc>().add(
                                  CheckoutCreated(
                                    userId: userId,
                                    items: items,
                                    currency: "USD",
                                  ),
                                );

                                //use go router to navigate
                                //context.push('/checkout');


                              },
                              text: 'Checkout',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is CartOperationFailure) {
              return ErrorWidget('Error: ${state.message}');
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
