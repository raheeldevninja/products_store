import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:products_store/features/cart/domain/entities/cart_item.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final ValueChanged<int> onQuantityChanged;
  final bool isUpdating;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onQuantityChanged,
    this.isUpdating = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: item.imageUrl.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 56,
                height: 56,
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (c, s) => Container(color: Colors.grey[200]),
                  errorWidget: (c, s, e) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
            )
          : const SizedBox(width: 56, height: 56),

      title: Text(item.name),
      subtitle: Text('\$${item.price.toStringAsFixed(2)} x ${item.quantity}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: isUpdating || item.quantity == 1
                ? null
                  : () => onQuantityChanged(item.quantity - 1),
            icon: const Icon(Icons.remove),
          ),

          Text('${item.quantity}'),

          IconButton(
            onPressed: isUpdating ? null : () => onQuantityChanged(item.quantity + 1),
            icon: const Icon(Icons.add),
          ),

          IconButton(
            onPressed: isUpdating ? null : onRemove,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }
}
