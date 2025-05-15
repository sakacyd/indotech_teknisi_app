import 'package:flutter/material.dart';

class InspectionChecklistWidget extends StatefulWidget {
  final Function(Map<String, String>) onChanged;

  const InspectionChecklistWidget({
    super.key,
    required this.onChanged,
  });

  @override
  State<InspectionChecklistWidget> createState() => _InspectionChecklistWidgetState();
}

class _InspectionChecklistWidgetState extends State<InspectionChecklistWidget> {
  final Map<String, String> checklistStatus = {
    'Tangki': '',
    'Kolektor': '',
    'Safety Valve': '',
    'Element Heating': '',
    'Anode': '',
    'Thermostat': '',
    'Listrik/Power': '',
    'Instalasi Pipa': '',
    'Bracket/Strap': '',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeaderRow(),
        const Divider(),
        ...checklistStatus.entries.map((entry) => _buildChecklistRow(entry.key)),
      ],
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      children: [
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(
            'Nama Sparepart/Service',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Kondisi/Keterangan',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const Expanded(
          child: Text(''),
        ),
      ],
    );
  }

  Widget _buildChecklistRow(String item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(item),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Radio<String>(
                  value: 'OK',
                  groupValue: checklistStatus[item],
                  onChanged: (value) => _updateStatus(item, value!),
                ),
                const Text('OK'),
                const SizedBox(width: 16),
                Radio<String>(
                  value: 'Rusak',
                  groupValue: checklistStatus[item],
                  onChanged: (value) => _updateStatus(item, value!),
                ),
                const Text('Rusak'),
              ],
            ),
          ),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Catatan',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateStatus(String item, String value) {
    setState(() {
      checklistStatus[item] = value;
      widget.onChanged(checklistStatus);
    });
  }
}