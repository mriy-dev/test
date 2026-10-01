import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: const ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.all(Radius.circular(16))),
        ),
        fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 44)),
        backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent),
        foregroundColor: WidgetStatePropertyAll(Colors.black),
        side: WidgetStatePropertyAll(BorderSide(color: Colors.blueAccent, width: 2)),
      ),
      onPressed: onTap,
      child: Text(label),
    );
  }
}
