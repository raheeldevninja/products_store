import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:products_store/core/extension/context.dart';
import 'package:products_store/features/checkout/domain/entities/checkout.dart';

class CheckoutSingleProduct extends StatelessWidget {
  const CheckoutSingleProduct({required this.checkoutItem, required this.currency, super.key});

  final CheckoutItem checkoutItem;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: checkoutItem.imageUrl,
              width: 60,
              height: 60,
              placeholder: (c, s) =>
                  Container(color: Colors.grey[200]),
              errorWidget: (c, s, e) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image),
              ),
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
                  style: context.textTheme.titleMedium!.copyWith(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${checkoutItem.price.toStringAsFixed(2)} x ${checkoutItem.quantity}",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorScheme.tertiaryFixedDim,
                  ),
                ),
              ],
            ),
          ),

          // Subtotal
          Text(
            "$currency ${(checkoutItem.price * checkoutItem.quantity).toStringAsFixed(2)}",
            style: context.textTheme.titleSmall!.copyWith(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
