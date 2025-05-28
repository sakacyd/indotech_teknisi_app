import 'package:flutter/material.dart';
import 'package:indotech_teknisi_app/features/report/domain/entities/inspection_item.dart';

class InspectionChecklistWidget extends StatefulWidget {
  final Function(List<InspectionItem>) onChanged;

  const InspectionChecklistWidget({super.key, required this.onChanged});

  @override
  State<InspectionChecklistWidget> createState() =>
      _InspectionChecklistWidgetState();
}

class _InspectionChecklistWidgetState extends State<InspectionChecklistWidget> {
  List<InspectionItem> items = [
    InspectionItem(id: '1', inspectionReportId: '', itemName: 'Tangki'),
    InspectionItem(id: '2', inspectionReportId: '', itemName: 'Kolektor'),
    InspectionItem(id: '3', inspectionReportId: '', itemName: 'Safety Valve'),
    InspectionItem(
      id: '4',
      inspectionReportId: '',
      itemName: 'Element Heating',
    ),
    InspectionItem(id: '5', inspectionReportId: '', itemName: 'Anode'),
    InspectionItem(id: '6', inspectionReportId: '', itemName: 'Thermostat'),
    InspectionItem(id: '7', inspectionReportId: '', itemName: 'Listrik/Power'),
    InspectionItem(id: '8', inspectionReportId: '', itemName: 'Instalasi Pipa'),
    InspectionItem(id: '9', inspectionReportId: '', itemName: 'Bracket/Strap'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 16, thickness: 1),
        ...items.asMap().entries.map((entry) => _buildChecklistRow(entry.key)),
      ],
    );
  }

  Widget _buildChecklistRow(int index) {
    final item = items[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Baris pertama: itemName di tengah
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Center(
            child: Text(
              item.itemName ?? '',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // Baris kedua: Quantity
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Row(
            children: [
              const Expanded(flex: 2, child: Text('Quantity')),
              Expanded(
                flex: 3,
                child: TextFormField(
                  initialValue: item.quantity?.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Qty',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      items[index] = item.copyWith(
                        quantity: int.tryParse(val) ?? 1,
                      );
                      widget.onChanged(items);
                    });
                  },
                ),
              ),
            ],
          ),
        ),

        // Baris ketiga: Kondisi/Keterangan
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Row(
            children: [
              const Expanded(flex: 2, child: Text('Kondisi/Keterangan')),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Radio<String>(
                      value: 'OK',
                      groupValue: item.condition,
                      onChanged: (value) {
                        setState(() {
                          items[index] = item.copyWith(condition: value);
                          widget.onChanged(items);
                        });
                      },
                    ),
                    const Text('OK'),
                    const SizedBox(width: 16),
                    Radio<String>(
                      value: 'Rusak',
                      groupValue: item.condition,
                      onChanged: (value) {
                        setState(() {
                          items[index] = item.copyWith(condition: value);
                          widget.onChanged(items);
                        });
                      },
                    ),
                    const Text('Rusak'),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Baris keempat: Catatan
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Row(
            children: [
              const Expanded(flex: 2, child: Text('Catatan')),
              Expanded(
                flex: 3,
                child: TextFormField(
                  initialValue: item.notes ?? '',
                  decoration: const InputDecoration(
                    hintText: 'Catatan',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      items[index] = item.copyWith(notes: val);
                      widget.onChanged(items);
                    });
                  },
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        const Divider(height: 16, thickness: 1),
      ],
    );
  }
}
