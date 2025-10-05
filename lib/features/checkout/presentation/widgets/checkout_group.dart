import 'package:flutter/material.dart';
import 'package:products_store/core/extension/context.dart';
import 'package:products_store/features/checkout/domain/entities/checkout.dart';
import 'package:products_store/features/checkout/presentation/widgets/checkout_single_product.dart';

class CheckoutGroup extends StatelessWidget {
  const CheckoutGroup({required this.checkout, required this.total, super.key,});

  final Checkout checkout;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkout date
            Text(
              "Date: ${checkout.createdAt.toLocal().toString().split(' ')[0]}",
              style: context.textTheme.bodyMedium!.copyWith(
                color: context.colorScheme.tertiaryFixedDim,
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
                return CheckoutSingleProduct(
                  checkoutItem: checkoutItem,
                  currency: checkout.currency,
                );
              },
            ),

            const Divider(thickness: 1, height: 24),

            // Total row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Total: ",
                  style: context.textTheme.titleMedium!.copyWith(fontSize: 16),
                ),
                Text(
                  "${checkout.currency} ${total.toStringAsFixed(2)}",
                  style: context.textTheme.titleMedium!.copyWith(
                    fontSize: 16,
                    color: context.colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
