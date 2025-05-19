import 'package:flutter/material.dart';

class InfoField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const InfoField({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
