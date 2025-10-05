import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:products_store/core/extension/context.dart';
import 'package:products_store/core/theme/bloc/theme_bloc.dart';
import 'package:products_store/core/theme/bloc/theme_event.dart';
import 'package:products_store/core/theme/bloc/theme_state.dart';
import 'package:products_store/core/theme/models/theme_mode_enum.dart';
import 'package:products_store/core/ui/widgets/app_button.dart';
import 'package:products_store/core/ui/widgets/app_dialog.dart';
import 'package:products_store/core/ui/widgets/base_app_bar.dart';
import 'package:products_store/core/ui/widgets/loading_indicator.dart';
import 'package:products_store/features/auth/presentation/bloc/auth_bloc.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Account Page'),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            context.go('/signIn');
          }
        },
        builder: (context, state) {

          if(state is AuthAuthenticated) {

            final user = state.user;

            // Build initials
            final initials = (user.name.isNotEmpty
                ? user.name.trim().split(' ').map((e) => e[0]).take(2).join()
                : user.email.isNotEmpty
                ? user.email[0]
                : '?')
                .toUpperCase();

            return  Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  CircleAvatar(
                    radius: 40,
                    backgroundColor: context.colorScheme.secondary,
                    child: Text(
                      initials,
                      style: context.textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    style: context.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: context.colorScheme.tertiaryFixedDim,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    height: 0,
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_bag_outlined),
                    title: Text(
                      "My Checkouts",
                      style: context.textTheme.bodyLarge,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.push('/checkout');
                    },
                  ),
                  const Divider(
                    height: 0,
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock_outline),
                    title: Text(
                      "Change Password",
                      style: context.textTheme.bodyLarge,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.push('/change-password');
                    },
                  ),
                  const Divider(
                    height: 0,
                  ),
                  ListTile(
                    leading: const Icon(Icons.brightness_6),
                    title: Text("Dark Mode", style: context.textTheme.bodyLarge,),
                    trailing: BlocBuilder<ThemeBloc, ThemeState>(

                    builder: (context, state) {

                        final isDarkMode = state.themeMode == ThemeMode.dark;

                        return Switch(
                          value: state.themeMode == ThemeMode.dark,
                          onChanged: (_) {
                            context.read<ThemeBloc>().add(ChangeThemeEvent(isDarkMode ? AppThemeMode.light : AppThemeMode.dark));
                          },
                        );
                      },
                    ),
                  ),

                  const Divider(
                    height: 0,
                  ),
                  const Spacer(),

                  const SizedBox(height: 12),

                  //logout button
                  AppButton(
                    onPressed: () => _handleLogout(context),
                    text: 'Logout',
                  ),

                ],
              ),
            );
          }

          return LoadingIndicator();
        },
      ),
    );
  }


  void _handleLogout(BuildContext context) async {
    final confirmed = await AppDialog.show(
      context: context,
      title: 'Logout',
      content: 'Are you sure you want to logout?',
      type: DialogType.confirm,
      confirmText: 'Logout',
    );

    if (!context.mounted) {
      return;
    }

    if (confirmed ?? false) {
      context.read<AuthBloc>().add(SignOutRequested());
    }
  }

}
