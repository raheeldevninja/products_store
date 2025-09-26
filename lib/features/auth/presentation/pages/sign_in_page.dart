import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_store/core/constants/validators.dart';
import 'package:products_store/core/extension/context.dart';
import 'package:products_store/core/ui/widgets/app_button.dart';
import 'package:products_store/core/ui/widgets/app_text_field.dart';
import 'package:products_store/core/ui/widgets/base_app_bar.dart';
import 'package:products_store/features/auth/auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: BaseAppBar(title: 'Sign In'),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {

          if (state is AuthAuthenticated) {
            context.go('/home');
          }
          else if (state is AuthFailure) {
            context.showSnackBarMessage(context, message: state.message);
          }

        },
        builder: (context, state) {

          final isLoading = state is AuthLoading;


          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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

                    AppTextField.password(
                      controller: _passwordController,
                      label: "Password",
                      hint: "Password",
                      validator: (value) {

                        if(Validators.isFieldEmpty(value)) {
                          return 'Password is required';
                        }

                        if ((value?.length ?? 0) < 6) {
                          return 'Password must be at least 6 characters';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          context.push('/forgot-password');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                        ),
                        child: const Text('Forgot Password?'),
                      ),
                    ),

                    const SizedBox(height: 24),

                    AppButton(
                      isLoading: isLoading,
                      onPressed: _submitLogin,
                      text: 'Login',
                    ),

                    const SizedBox(height: 16),

                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: context.textTheme.bodyLarge,
                        children: [
                          TextSpan(
                            text: "Register",
                            style: context.textTheme.titleMedium,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.push('/signUp');
                              },
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitLogin() {

    //bool isConnected = _noInternetCheck(context);

    // if(!isConnected) {
    //   return;
    // }

    if (_formKey.currentState?.validate() ?? false) {

      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      context.read<AuthBloc>().add(SignInRequested(email: email, password: password));

    }
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }
}
