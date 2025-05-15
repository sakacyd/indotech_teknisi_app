import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indotech_teknisi_app/core/theme/app_pallete.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: AppPallete.primaryColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppPallete.secondaryColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
