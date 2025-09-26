import 'package:flutter/material.dart';
import 'package:products_store/core/ui/widgets/base_app_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Cart Page'),
    );
  }
}
