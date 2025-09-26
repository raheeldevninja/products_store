import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store/core/app/style.dart';
import 'package:products_store/features/product/data/data_sources/products_service.dart';
import 'package:products_store/features/product/data/repositories/product_repository_impl.dart';
import 'package:products_store/features/product/domain/use_cases/get_products.dart';
import 'package:products_store/features/product/presentation/bloc/products_bloc.dart';
import 'package:products_store/features/product/presentation/pages/products_page.dart';

class ProductStoreApp extends StatelessWidget {
  const ProductStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(
          create: (_) =>
              ProductsBloc(getProducts: GetProducts(ProductRepositoryImpl(ProductsService()))),
        ),
      ],
      child: MaterialApp(
        title: 'Products Store',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: ProductsPage(),
      ),
    );
  }
}
