import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_store/core/constants/validators.dart';
import 'package:products_store/core/extension/context.dart';
import 'package:products_store/core/ui/widgets/app_button.dart';
import 'package:products_store/core/ui/widgets/app_text_field.dart';
import 'package:products_store/core/ui/widgets/base_app_bar.dart';
import 'package:products_store/features/auth/auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {

        if (state is AuthPasswordReset) {

          context.showSnackBarMessage(
              context,
              message: "Password reset email sent!",
              contentType: ContentType.success,
          );

          Future.delayed(const Duration(milliseconds: 300), () {
            if (context.mounted) context.pop();
          });

        }
        else if (state is AuthFailure) {
          context.showSnackBarMessage(context, message: state.message);
        }

      },
      builder: (context, state) {

        final isLoading = state is AuthLoading;

        return Scaffold(
          appBar: BaseAppBar(title: 'Forgot Password', isLoading: isLoading, showBackButton: true,),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    label: "Email",
                    hint: "Email",
                    validator: (value) {

                      if(Validators.isFieldEmpty(value)) {
                        return 'Email is required';
                      }

                      if (!Validators.isEmailValid(value)) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  AppButton(
                    isLoading: isLoading,
                    onPressed: _resetPassword,
                    text: "Reset Password",
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _resetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        PasswordResetRequested(email: _emailController.text),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

}
