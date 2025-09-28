import 'package:flutter/material.dart';
import 'package:products_store/core/app/style.dart';
import 'package:products_store/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:products_store/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:products_store/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:products_store/features/home/home.dart';
import 'package:products_store/features/notification/data/notification_service.dart';
import 'package:products_store/features/product/data/data_sources/products_service.dart';
import 'package:products_store/features/product/data/repositories/product_repository_impl.dart';
import 'package:products_store/features/product/domain/use_cases/get_products.dart';
import 'package:products_store/features/product/presentation/bloc/products_bloc.dart';

class ProductStoreApp extends StatelessWidget {

  const ProductStoreApp({
    super.key,
    required this.router,
    required this.authBloc,
    required this.cartBloc,
    required this.checkoutBloc,
  });

  final RouterConfig<Object> router;
  final AuthBloc authBloc;
  final CartBloc cartBloc;
  final CheckoutBloc checkoutBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider<ProductsBloc>(
          create: (_) =>
              ProductsBloc(getProducts: GetProducts(ProductRepositoryImpl(ProductsService()))),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
        BlocProvider(create: (_) => cartBloc),
        BlocProvider(create: (_) => checkoutBloc),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state)  async {

          final cartBloc = context.read<CartBloc>();

          if (state is AuthAuthenticated) {
            cartBloc.add(CartStarted(state.user.uid));

            // after user authenticates (AuthAuthenticated)
            final notifService = NotificationService();
            await notifService.init(currentUserId: state.user.uid);
            final token = await notifService.getToken();
            if (token != null) await notifService.saveTokenForUser(userId: state.user.uid, token: token);


          } else if (state is AuthUnauthenticated) {
            cartBloc.add(CartCleared());
          }

        },
        child: MaterialApp.router(
          title: 'Products Store',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          routerConfig: router,
        ),
      ),
    );
  }
}
