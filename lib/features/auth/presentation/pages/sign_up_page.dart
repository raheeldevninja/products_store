import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_store/core/constants/validators.dart';
import 'package:products_store/core/extension/context.dart';
import 'package:products_store/core/ui/widgets/app_button.dart';
import 'package:products_store/core/ui/widgets/app_text_field.dart';
import 'package:products_store/core/ui/widgets/base_app_bar.dart';
import 'package:products_store/features/auth/auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {

        if (state is AuthAuthenticated) {

          context.go('/home');

        } else if (state is AuthFailure) {
          context.showSnackBarMessage(context, message: state.message);
        }

      },
      builder: (context, state) {

        final isLoading = state is AuthLoading;

        return Scaffold(
          appBar: BaseAppBar(title: 'Sign Up', isLoading: isLoading, showBackButton: true,),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextField(
                      controller: _nameController,
                      label: "Name",
                      hint: "Name",
                      validator: (value) {

                        if(Validators.isFieldEmpty(value)) {
                          return 'Please enter your name';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 24),
                    AppButton(
                      isLoading: isLoading,
                      onPressed: _submitRegister,
                      text: 'Register',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _submitRegister() {
    bool isConnected = _noInternetCheck(context);

    if (!isConnected) {
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {

      context.read<AuthBloc>().add(
        SignUpRequested(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  bool _noInternetCheck(BuildContext context) {
    // final connectivityState = context.read<ConnectivityBloc>().state;
    //
    // if (connectivityState is ConnectivityOffline) {
    //   context.showSnackBarMessage(context, message: Constants.noInternet);
    //
    //   return false;
    // }

    return true;
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}

