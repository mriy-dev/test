import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => FilledButton(onPressed: onTap, child: Text(label));
}
