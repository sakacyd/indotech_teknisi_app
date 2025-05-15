import 'package:flutter/material.dart';

class SignatureSection extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;

  const SignatureSection({
    super.key, 
    required this.leftTitle,
    required this.rightTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: _buildSignatureColumn(leftTitle),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSignatureColumn(rightTitle),
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureColumn(String title) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text('Tanda tangan di sini'),
          ),
        ),
        const SizedBox(height: 8),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Nama',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
