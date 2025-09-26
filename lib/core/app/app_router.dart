import 'package:go_router/go_router.dart';
import 'package:products_store/features/account/presentation/pages/account_page.dart';
import 'package:products_store/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:products_store/features/auth/presentation/pages/sign_in_page.dart';
import 'package:products_store/features/auth/presentation/pages/sign_up_page.dart';
import 'package:products_store/features/cart/presentation/pages/cart_page.dart';
import 'package:products_store/features/home/presentation/pages/home_screen.dart';
import 'package:products_store/features/product/presentation/pages/products_page.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/signIn',
    //refreshListenable: GoRouterRefreshStream(authBloc.stream),
    // redirect: (context, state) {
    //   final authState = authBloc.state;
    //
    //   if(authState is Authenticated) {
    //     return '/dashboard';
    //   }
    //   else if(authState is UnAuthenticated || authState is AuthInitial) {
    //     return '/signIn';
    //   }
    //
    //   return null;
    // },
    routes: [
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
    ],
  );
}
