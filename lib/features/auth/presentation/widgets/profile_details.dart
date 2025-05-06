import 'package:flutter/material.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';

class ProfileDetails extends StatelessWidget {
  final User user;

  const ProfileDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> details = [
      {'title': 'ID Teknisi', 'value': user.id},
      {'title': 'Nama', 'value': user.name},
      {'title': 'Phone Number', 'value': user.phoneNumber},
      {'title': 'E-mail', 'value': user.email},
      {'title': 'Address', 'value': user.address},
    ];

    return Column(
      children:
          details.map((detail) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail['title']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      detail['value']!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
