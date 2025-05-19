import 'package:flutter/material.dart';
import 'info_field.dart'; // pastikan import ini sudah sesuai path kamu

class InstallationSection extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String> onChanged;

  const InstallationSection({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<InstallationSection> createState() => _InstallationSectionState();
}

class _InstallationSectionState extends State<InstallationSection> {
  final List<String> _options = [
    'Genteng',
    'Dak / Atap Datar',
    'Plafon',
    'Dinding',
  ];

  String? _selectedOption;
  final TextEditingController _otherController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null) {
      if (_options.contains(widget.initialValue)) {
        _selectedOption = widget.initialValue;
      } else {
        _selectedOption = 'Lainnya';
        _otherController.text = widget.initialValue!;
      }
    }

    _otherController.addListener(() {
      if (_selectedOption == 'Lainnya') {
        widget.onChanged(_otherController.text);
      }
    });
  }

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  void _notifyChange() {
    if (_selectedOption == 'Lainnya') {
      widget.onChanged(_otherController.text);
    } else {
      widget.onChanged(_selectedOption ?? '');
    }
  }

  String? _validateOtherField(String? value) {
    if (_selectedOption == 'Lainnya' && (value == null || value.isEmpty)) {
      return 'Mohon isi lokasi lain';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ..._options.map(
              (option) => ChoiceChip(
                label: Text(option, overflow: TextOverflow.ellipsis),
                selected: _selectedOption == option,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedOption = option;
                      _otherController.clear();
                    } else {
                      _selectedOption = null;
                    }
                    _notifyChange();
                  });
                },
                labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                selectedColor: Colors.blue.shade200,
                backgroundColor: Colors.grey.shade200,
              ),
            ),
            ChoiceChip(
              label: const Text('Lainnya'),
              selected: _selectedOption == 'Lainnya',
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedOption = 'Lainnya';
                  } else {
                    _selectedOption = null;
                    _otherController.clear();
                    _notifyChange();
                  }
                });
              },
              labelPadding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              selectedColor: Colors.blue.shade200,
              backgroundColor: Colors.grey.shade200,
            ),
          ],
        ),

        if (_selectedOption == 'Lainnya') ...[
          const SizedBox(height: 8),
          SizedBox(
            child: InfoField(
              controller: _otherController,
              label: 'Isi lokasi lain',
              validator: _validateOtherField,
            ),
          ),
        ],
      ],
    );
  }
}
