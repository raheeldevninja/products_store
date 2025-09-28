import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:products_store/core/extension/context.dart';
import 'package:products_store/core/ui/widgets/base_app_bar.dart';
import 'package:products_store/core/ui/widgets/empty_layout.dart';
import 'package:products_store/core/ui/widgets/loading_indicator.dart';
import 'package:products_store/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:products_store/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:products_store/features/product/products.dart';

import '../widgets/product_tile.dart';

class ProductsPage extends StatefulWidget {

  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  final _scrollController = ScrollController();
  late ProductsBloc _productsBloc;

  @override
  void initState() {
    super.initState();
    _productsBloc = context.read<ProductsBloc>();
    _productsBloc.add(const ProductsFetched());
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Products'),
      body: Column(
        children: [

          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {

              if (state is AuthAuthenticated) {

                final user = state.user;
                final initials = _getInitials(user.name);

                return Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey.shade100,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.black,
                        child: Text(
                          initials,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: context.textTheme.bodyLarge,
                          ),
                          Text(
                            user.email,
                            style: context.textTheme.bodyMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          Expanded(
            child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {

                if (state is ProductsInitial || state is ProductsLoadInProgress) {
                  return LoadingIndicator();
                }
                else if (state is ProductsLoadFailure) {
                  return ErrorWidget(state.error);
                }
                else if(state is ProductsLoadSuccess) {
                  final products = state.products;

                  if (products.isEmpty) {
                    return EmptyLayout('No products yet');
                  }

                  return RefreshIndicator(
                      color: Colors.black,
                      onRefresh: () async {
                        _productsBloc.add(const ProductsFetched(isRefresh: true));
                      },
                      child: ListView.separated(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          if (index >= products.length) {
                            return LoadingIndicator();
                          }
                          final product = products[index];
                          return ProductTile(product: product, onAddToCart: () => _onAddToCart(product));
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemCount: state.hasReachedMax ? products.length : products.length + 1,
                      ),
                  );
                }

                return const SizedBox.shrink();

              },
            ),
          ),
        ],
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) {
      _productsBloc.add(const ProductsFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final max = _scrollController.position.maxScrollExtent;
    final current = _scrollController.offset;
    return current >= (max * 0.9);
  }

  void _onAddToCart(Product product) {

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
  }

  String _getInitials(String? text) {

    if (text == null || text.isEmpty) return "?";

    final parts = text.trim().split(" ");

    if (parts.length == 1) return parts[0][0].toUpperCase();

    return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
