import 'package:flutter/material.dart';
import 'package:indotech_teknisi_app/core/common/entities/report.dart';

class CustomerInfoSection extends StatelessWidget {
  final Report report;

  const CustomerInfoSection({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nama Customer: ${report.customerName}'),
        Text('No. Telp / HP: ${report.customerPhoneNumber}'),
        Text('Alamat: ${report.customerAddress}'),
        const SizedBox(height: 10),
      ],
    );
  }
}
