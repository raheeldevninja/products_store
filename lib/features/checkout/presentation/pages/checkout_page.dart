import 'package:flutter/material.dart';
import 'package:products_store/core/ui/widgets/base_app_bar.dart';
import 'package:products_store/core/ui/widgets/empty_layout.dart';
import 'package:products_store/core/ui/widgets/loading_indicator.dart';
import 'package:products_store/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:products_store/features/checkout/checkouts.dart';
import 'package:products_store/features/checkout/presentation/widgets/checkout_group.dart';

class CheckoutPage extends StatefulWidget {

  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  late CheckoutBloc _checkoutBloc;

  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;
    final userId = (authState is AuthAuthenticated) ? authState.user.uid : null;

    _checkoutBloc = context.read<CheckoutBloc>();
    _checkoutBloc.add(CheckoutStarted(userId ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Checkout', showBackButton: true,),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {

          if (state is CheckoutLoadInProgress) {
            return LoadingIndicator();
          }
          else if (state is CheckoutLoadSuccess) {

            final checkouts = state.checkouts;

            if (checkouts.isEmpty) {
              return EmptyLayout('No checkouts found');
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: checkouts.length,
              itemBuilder: (context, index) {
                final checkout = checkouts[index];

                // calculate total
                final total = checkout.items.fold<double>(
                  0.0,
                      (add, item) => add + (item.price * item.quantity),
                );

                return CheckoutGroup(checkout: checkout, total: total);
              },
            );

          }
          else if (state is CheckoutFailure) {
            return ErrorWidget(state.message);
          }

          return const SizedBox();

        },
      ),
    );
  }
}
