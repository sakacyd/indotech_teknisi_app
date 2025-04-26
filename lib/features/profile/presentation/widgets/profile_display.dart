import 'package:flutter/material.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';

class ProfileInfo extends StatelessWidget {
  final User user;
  const ProfileInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInfoField('Nama', user.name ?? '-'),
        _buildInfoField('Email', user.email ?? '-'),
        _buildInfoField('No. Telepon', user.phoneNumber ?? '-'),
        _buildInfoField('Alamat', user.address ?? '-'),
        _buildInfoField('Tanggal Lahir', user.birthDate ?? '-'),
        _buildInfoField('Role', user.role ?? '-'),
      ],
    );
  }

  Widget _buildInfoField(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
