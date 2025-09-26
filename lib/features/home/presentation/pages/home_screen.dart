import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_store/features/home/home.dart';

class HomeScreen extends StatelessWidget {

  final Widget child;
  const HomeScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }
}
