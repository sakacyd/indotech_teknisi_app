import 'package:flutter/material.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';

class CustomerInfoWidget extends StatelessWidget {
  final Report report;

  const CustomerInfoWidget({super.key, required this.report});

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
              'Customer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInfoField('Nama Customer', report.customerName ?? '-'),
            _buildInfoField('No. Telp / HP', report.customerPhoneNumber ?? '-'),
            _buildInfoField('Alamat', report.customerAddress ?? '-'),
            _buildInfoField('PIC', ''),
            _buildInfoField('No Telp / HP PIC', ''),
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
