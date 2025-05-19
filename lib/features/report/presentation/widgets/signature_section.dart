import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:indotech_teknisi_app/features/report/presentation/widgets/info_field.dart';
import 'package:signature/signature.dart';

class SignatureSection extends StatefulWidget {
  final String value;
  final String title;
  final SignatureController controller;
  final TextEditingController textController;
  final void Function(Uint8List?)? onSignatureSaved;

  const SignatureSection({
    super.key,
    required this.value,
    required this.title,
    required this.controller,
    required this.textController,
    this.onSignatureSaved,
  });

  @override
  State<SignatureSection> createState() => _SignatureSectionState();
}

class _SignatureSectionState extends State<SignatureSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Signature(
            controller: widget.controller,
            backgroundColor: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                widget.controller.clear();
              },
              icon: const Icon(Icons.clear),
              label: const Text("Hapus"),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () async {
                if (widget.controller.isNotEmpty) {
                  final signatureBytes = await widget.controller.toPngBytes();
                  if (signatureBytes != null) {
                    widget.onSignatureSaved?.call(signatureBytes);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Tanda tangan disimpan sebagai PNG"),
                      ),
                    );
                  }
                }
              },
              icon: const Icon(Icons.download),
              label: const Text("Simpan"),
            ),
          ],
        ),
        const SizedBox(height: 12),
        InfoField(
          controller: widget.textController,
          label: 'Nama',
        ),
      ],
    );
  }
}
