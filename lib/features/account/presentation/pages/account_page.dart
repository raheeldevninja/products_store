import 'package:flutter/material.dart';
import 'package:products_store/core/ui/widgets/base_app_bar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Account Page')
    );
  }
}
