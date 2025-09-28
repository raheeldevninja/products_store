import 'package:flutter/material.dart';
import 'package:products_store/core/extension/context.dart';
import 'package:products_store/core/ui/widgets/app_button.dart';
import 'package:products_store/core/ui/widgets/base_app_bar.dart';
import 'package:products_store/core/ui/widgets/empty_layout.dart';
import 'package:products_store/core/ui/widgets/loading_indicator.dart';
import 'package:products_store/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:products_store/features/cart/cart.dart';
import 'package:products_store/features/cart/presentation/widgets/cart_item_tile.dart';

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
      body: BlocConsumer<CartBloc, CartState>(
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
                          const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('\$${state.total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      AppButton(
                        onPressed: state.outOfStock ? null : () {
                          // handle checkout
                        },
                        text: 'Checkout',
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
    );
  }
}
