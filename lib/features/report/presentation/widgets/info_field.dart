import 'package:flutter/material.dart';

class InfoField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String value;

  const InfoField({
    super.key,
    required this.controller,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
