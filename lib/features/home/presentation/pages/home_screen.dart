import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_store/features/cart/cart.dart';
import 'package:products_store/features/home/home.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatelessWidget {

  final Widget child;
  const HomeScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(

      builder: (context, state) {

        final currentIndex = state.currentIndex;

        return Scaffold(
          body: child,
          bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {

              int cartCount = 0;

              if (cartState is CartLoadSuccess) {
                cartCount = cartState.items.fold<int>(
                  0,
                      (add, item) => add + item.quantity,
                );
              }

              return BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (index) {
                  context.read<HomeBloc>().add(TabChangedEvent(index: index));
                  // Navigate based on index
                  switch (index) {
                    case 0:
                      context.go('/home');
                      break;
                    case 1:
                      context.go('/cart');
                      break;
                    case 2:
                      context.go('/account');
                      break;
                  }
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: badges.Badge(
                      showBadge: cartCount > 0,
                      badgeContent: Text(
                        cartCount.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      child: const Icon(Icons.shopping_cart),
                    ),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Account',
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
