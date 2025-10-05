import 'package:go_router/go_router.dart';
import 'package:products_store/core/app/go_router_refresh_stream.dart';
import 'package:products_store/features/account/presentation/pages/account_page.dart';
import 'package:products_store/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:products_store/features/auth/presentation/pages/change_password_page.dart';
import 'package:products_store/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:products_store/features/auth/presentation/pages/sign_in_page.dart';
import 'package:products_store/features/auth/presentation/pages/sign_up_page.dart';
import 'package:products_store/features/auth/presentation/pages/splash_page.dart';
import 'package:products_store/features/cart/presentation/pages/cart_page.dart';
import 'package:products_store/features/checkout/checkouts.dart';
import 'package:products_store/features/checkout/data/data_sources/checkout_remote_data_source.dart';
import 'package:products_store/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:products_store/features/checkout/presentation/pages/checkout_page.dart';
import 'package:products_store/features/home/presentation/bloc/home_bloc.dart';
import 'package:products_store/features/home/presentation/pages/home_screen.dart';
import 'package:products_store/features/product/domain/entity/product.dart';
import 'package:products_store/features/product/presentation/pages/product_details_page.dart';
import 'package:products_store/features/product/presentation/pages/products_page.dart';

GoRouter createRouter(AuthBloc authBloc) {
  return GoRouter(
    initialLocation: '/signIn',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;

      // While still initializing, stay on splash
      if (authState is AuthInitial) {
        return state.fullPath == '/splash' ? null : '/splash';
      }

      // Authenticated → go home
      if (authState is AuthAuthenticated) {
        if (state.fullPath == '/signIn' ||
            state.fullPath == '/signUp' ||
            state.fullPath == '/forgot-password' ||
            state.fullPath == '/splash') {
          context.read<HomeBloc>().add(const TabChangedEvent(index: 0));
          return '/home';
        }
        return null; // allow current route
      }

      // Unauthenticated → force to sign in
      if (authState is AuthUnauthenticated) {
        if (state.fullPath != '/signIn' &&
            state.fullPath != '/signUp' &&
            state.fullPath != '/forgot-password') {
          return '/signIn';
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/signIn',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: '/signUp',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return HomeScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const ProductsPage(),
          ),
          GoRoute(
            path: '/cart',
            builder: (context, state) => const CartPage(),
          ),
          GoRoute(
            path: '/account',
            builder: (context, state) => const AccountPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/product-details',
        builder: (context, state) {
          final product = state.extra as Product;
          return ProductDetailsPage(product: product);
        },
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => BlocProvider(

          create: (_) => CheckoutBloc(
              createCheckout: CreateCheckout(CheckoutRepositoryImpl(CheckoutRemoteDataSource())),
              confirmCheckout: ConfirmCheckout(CheckoutRepositoryImpl(CheckoutRemoteDataSource())),
              cancelCheckout: CancelCheckout(CheckoutRepositoryImpl(CheckoutRemoteDataSource())),
              getUserCheckouts: GetUserCheckouts(CheckoutRepositoryImpl(CheckoutRemoteDataSource())),
          ),

            child: const CheckoutPage(),
          ),
        ),

      GoRoute(
        path: '/change-password',
        builder: (context, state) {
          return ChangePasswordPage();
        },
      ),

    ],
  );
}
