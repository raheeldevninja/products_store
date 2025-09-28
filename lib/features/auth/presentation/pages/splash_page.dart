import 'package:flutter/material.dart';
import 'package:products_store/core/ui/widgets/loading_indicator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
