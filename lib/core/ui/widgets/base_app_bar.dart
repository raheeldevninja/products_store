import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool isLoading;

  const BaseAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: isLoading
                  ? null : () => Navigator.of(context).pop(),
            )
          : null,
      title: Text(title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
