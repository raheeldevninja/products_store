import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:products_store/core/extension/context.dart';
import 'package:products_store/features/product/domain/entity/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductTile({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 90,
                height: 90,
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (c, s) => Container(color: Colors.grey[200]),
                  errorWidget: (c, s, e) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: context.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatPrice(product.price, product.currency),
                        style: context.textTheme.titleMedium,
                      ),
                      ElevatedButton.icon(
                        onPressed: onAddToCart,
                        icon: const Icon(Icons.add_shopping_cart_outlined),
                        label: const Text('Add'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(double price, String currency) {
    return '$currency ${price.toStringAsFixed(2)}';
  }
}
