import 'package:flutter/material.dart';
import 'package:webspark/core/widgets/primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      floatingActionButton: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: AppPrimaryButton(label: 'Start counting process'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        physics: const ClampingScrollPhysics(),
        children: [
          const Text('Set a valid Api base Url in order to continue'),
          Row(
            children: [
              const Icon(Icons.read_more),
              Expanded(child: TextFormField()),
            ],
          ),
        ],
      ),
    );
  }
}
