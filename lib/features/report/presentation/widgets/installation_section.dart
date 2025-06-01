import 'package:flutter/material.dart';
import 'info_field.dart'; // pastikan import ini sudah sesuai path kamu

class InstallationSection extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final List<String> options;
  final String label;
  final String otherOptionLabel;

  const InstallationSection({
    super.key,
    this.initialValue,
    required this.onChanged,
    required this.options,
    required this.label,
    required this.otherOptionLabel,
  });

  @override
  State<InstallationSection> createState() => _InstallationSectionState();
}

class _InstallationSectionState extends State<InstallationSection> {
  late List<String> _options;
  String? _selectedOption;
  final TextEditingController _otherController = TextEditingController();
  final String _internalOtherKey = '__OTHER__';

  @override
  void initState() {
    super.initState();
    _options = widget.options;

    if (widget.initialValue != null) {
      if (_options.contains(widget.initialValue)) {
        _selectedOption = widget.initialValue;
      } else {
        _selectedOption = _internalOtherKey;
        _otherController.text = widget.initialValue!;
      }
    }

    _otherController.addListener(() {
      if (_selectedOption == _internalOtherKey) {
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
    if (_selectedOption == _internalOtherKey) {
      widget.onChanged(_otherController.text);
    } else {
      widget.onChanged(_selectedOption ?? '');
    }
  }

  String? _validateOtherField(String? value) {
    if (_selectedOption == _internalOtherKey &&
        (value == null || value.isEmpty)) {
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
              label: Text(widget.otherOptionLabel),
              selected: _selectedOption == _internalOtherKey,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedOption = _internalOtherKey;
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
        if (_selectedOption == _internalOtherKey) ...[
          const SizedBox(height: 8),
          SizedBox(
            child: InfoField(
              controller: _otherController,
              label: widget.label,
              validator: _validateOtherField,
            ),
          ),
        ],
      ],
    );
  }
}
