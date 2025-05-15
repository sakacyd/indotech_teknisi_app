import 'package:flutter/material.dart';

class LocationSelectionWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onChanged;
  
  const LocationSelectionWidget({
    super.key,
    required this.onChanged,
  });

  @override
  State<LocationSelectionWidget> createState() => _LocationSelectionWidgetState();
}

class _LocationSelectionWidgetState extends State<LocationSelectionWidget> {
  String? selectedLocation;
  String? selectedStructure;
  bool isObstructed = false;
  
  final locations = ['Genteng', 'Dak', 'Plafon', 'Dinding'];
  final structures = ['Kayu', 'Baja Ringan'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Lokasi Pemasangan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: locations.map((location) {
            return ChoiceChip(
              label: Text(location),
              selected: selectedLocation == location,
              onSelected: (selected) {
                setState(() {
                  selectedLocation = selected ? location : null;
                });
                _notifyChange();
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        const Text('Jenis Rangka Genteng',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        Wrap(
          spacing: 8,
          children: structures.map((structure) {
            return ChoiceChip(
              label: Text(structure),
              selected: selectedStructure == structure,
              onSelected: (selected) {
                setState(() {
                  selectedStructure = selected ? structure : null;
                });
                _notifyChange();
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        CheckboxListTile(
          title: const Text('Terhalang bayangan'),
          subtitle: const Text('seperti pohon, gedung, dll'),
          value: isObstructed,
          onChanged: (value) {
            setState(() {
              isObstructed = value ?? false;
            });
            _notifyChange();
          },
        ),
      ],
    );
  }

  void _notifyChange() {
    widget.onChanged({
      'location': selectedLocation,
      'structure': selectedStructure,
      'isObstructed': isObstructed,
    });
  }
}