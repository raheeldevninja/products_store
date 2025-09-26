import 'package:flutter/material.dart';
import 'package:products_store/core/extension/context.dart';

class EmptyLayout extends StatelessWidget {
  const EmptyLayout(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message, style: context.textTheme.bodyMedium));
  }
}
