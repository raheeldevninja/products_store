import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:products_store/core/ui/widgets/app_button.dart';
import 'package:products_store/core/ui/widgets/app_dialog.dart';
import 'package:products_store/core/ui/widgets/base_app_bar.dart';
import 'package:products_store/features/auth/presentation/bloc/auth_bloc.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Account Page'),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            context.go('/signIn');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //logout button
              AppButton(
                onPressed: () => _handleLogout(context),
                text: 'Logout',
              ),

            ],
          ),
        ),
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
