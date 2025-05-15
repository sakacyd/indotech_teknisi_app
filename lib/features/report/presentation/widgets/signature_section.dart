import 'package:flutter/material.dart';

class SignatureSection extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;

  const SignatureSection({
    required this.leftTitle,
    required this.rightTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _signatureBlock(leftTitle)),
        Expanded(child: _signatureBlock(rightTitle)),
      ],
    );
  }

  Widget _signatureBlock(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        const Text("Signature:"),
        const Text("Name:"),
      ],
    );
  }
}
