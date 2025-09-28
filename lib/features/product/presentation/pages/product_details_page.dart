import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store/core/extension/context.dart';
import 'package:products_store/core/ui/widgets/base_app_bar.dart';
import 'package:products_store/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:products_store/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:products_store/features/product/domain/entity/product.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: product.name),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            AspectRatio(
              aspectRatio: 1.2,
              child: ClipRRect(
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
            ),

            const SizedBox(height: 20),

            // Name
            Text(
              product.name,
              style: context.textTheme.titleLarge,
            ),
            const SizedBox(height: 10),

            // Price
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: context.textTheme.titleLarge?.copyWith(color: Colors.green),
            ),
            const SizedBox(height: 20),

            // Description
            Text(
              product.description,
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),

            // Add to cart button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {

                  final authState = context.read<AuthBloc>().state;

                  if (authState is! AuthAuthenticated) {
                    context.showSnackBarMessage(context, message: 'You must be logged in to add items to cart', contentType: ContentType.failure);
                    return;
                  }

                  final userId = authState.user.uid;

                  context.read<CartBloc>().add(
                    CartAddRequested(
                      userId: userId,
                      productId: product.id,
                      name: product.name,
                      price: product.price,
                      currency: product.currency,
                      imageUrl: product.imageUrl,
                      quantity: 1,
                    ),
                  );


                  // Use the event to add to cart
                  context.showSnackBarMessage(context, message: 'Added to cart', contentType: ContentType.success);


                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text("Add to Cart"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
