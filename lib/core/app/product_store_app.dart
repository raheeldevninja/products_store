import 'package:flutter/material.dart';
import 'package:products_store/core/app/style.dart';

class ProductStoreApp extends StatelessWidget {
  const ProductStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products Store',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
