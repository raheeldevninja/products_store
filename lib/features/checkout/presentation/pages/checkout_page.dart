import 'package:flutter/material.dart';
import 'package:products_store/core/ui/widgets/base_app_bar.dart';
import 'package:products_store/core/ui/widgets/empty_layout.dart';
import 'package:products_store/core/ui/widgets/loading_indicator.dart';
import 'package:products_store/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:products_store/features/checkout/checkouts.dart';

class CheckoutPage extends StatefulWidget {

  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  late CheckoutBloc _checkoutBloc;

  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;
    final userId = (authState is AuthAuthenticated) ? authState.user.uid : null;

    _checkoutBloc = context.read<CheckoutBloc>();
    _checkoutBloc.add(CheckoutStarted(userId ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Checkout', showBackButton: true,),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {

          if (state is CheckoutLoadInProgress) {
            return LoadingIndicator();
          }
          else if (state is CheckoutLoadSuccess) {

            final checkouts = state.checkouts;

            if (checkouts.isEmpty) {
              return EmptyLayout('No checkouts found');
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: checkouts.length,
              itemBuilder: (context, index) {
                final checkout = checkouts[index];

                // calculate total
                final total = checkout.items.fold<double>(
                  0.0,
                      (add, item) => add + (item.price * item.quantity),
                );

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Checkout date
                        Text(
                          "Date: ${checkout.createdAt.toLocal().toString().split(' ')[0]}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Items list
                        ListView.builder(
                          itemCount: checkout.items.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, itemIndex) {
                            final checkoutItem = checkout.items[itemIndex];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      checkoutItem.imageUrl,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  // Item details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          checkoutItem.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "${checkoutItem.price.toStringAsFixed(2)} x ${checkoutItem.quantity}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Subtotal
                                  Text(
                                    "${checkout.currency} ${(checkoutItem.price * checkoutItem.quantity).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        const Divider(thickness: 1, height: 24),

                        // Total row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "Total: ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${checkout.currency} ${total.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );


          }
          else if (state is CheckoutFailure) {
            return ErrorWidget(state.message);
          }

          return const SizedBox();

        },
      ),
    );
  }
}
