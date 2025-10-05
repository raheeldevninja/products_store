import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:products_store/core/constants/validators.dart';
import 'package:products_store/core/extension/context.dart';
import 'package:products_store/core/ui/widgets/app_button.dart';
import 'package:products_store/core/ui/widgets/app_text_field.dart';
import 'package:products_store/core/ui/widgets/base_app_bar.dart';
import 'package:products_store/features/auth/auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthPasswordChanged) {
          context.showSnackBarMessage(
            context,
            message: "Password changed successfully!",
            contentType: ContentType.success,
          );

          Future.delayed(const Duration(milliseconds: 300), () {

            if (!context.mounted) {
              return;
            }

            context.read<AuthBloc>().add(SignOutRequested());


          });

        } else if (state is AuthFailure) {
          context.showSnackBarMessage(context, message: state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          appBar: BaseAppBar(
            title: 'Change Password',
            isLoading: isLoading,
            showBackButton: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  AppTextField.password(
                    controller: _currentPasswordController,
                    label: "Current Password",
                    hint: "Current Password",
                    validator: (value) {

                      if (Validators.isFieldEmpty(value)) {
                        return 'Current password is required';
                      }

                      if (value!.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  AppTextField.password(
                    controller: _passwordController,
                    label: "New Password",
                    hint: "Enter new password",
                    validator: (value) {
                      if (Validators.isFieldEmpty(value)) {
                        return 'Password is required';
                      }
                      if (value!.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  AppTextField.password(
                    controller: _confirmPasswordController,
                    label: "Confirm Password",
                    hint: "Confirm new password",
                    validator: (value) {
                      if (value != _passwordController.text.trim()) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  AppButton(
                    isLoading: isLoading,
                    onPressed: _changePassword,
                    text: "Change Password",
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _changePassword() {
    if (_formKey.currentState?.validate() ?? false) {

      context.read<AuthBloc>().add(
        ChangePasswordRequested(
          currentPassword: _currentPasswordController.text.trim(),
          newPassword: _passwordController.text.trim(),
        ),
      );

    }

  }

  @override
  void dispose() {

    _currentPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

}
