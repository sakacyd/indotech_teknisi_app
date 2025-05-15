import 'package:flutter/material.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';

class ProductInfoWidget extends StatelessWidget {
  final Report report;
  
  const ProductInfoWidget({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Produk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoField('Nama Produk', report.unit ?? '-'),
            _buildInfoField('Jumlah', report.unitQuantity ?? '-'),
            _buildInfoField('Nomor Seri Tangki', ''),
            _buildInfoField('Nomor Seri Kolektor', ''),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
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