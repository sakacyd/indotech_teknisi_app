import 'package:flutter/material.dart';

class InstallationStatusWidget extends StatefulWidget {
  final Function(Map<String, bool>) onChanged;

  const InstallationStatusWidget({
    super.key,
    required this.onChanged,
  });

  @override
  State<InstallationStatusWidget> createState() => _InstallationStatusWidgetState();
}

class _InstallationStatusWidgetState extends State<InstallationStatusWidget> {
  final Map<String, bool> installationStatus = {
    'tangki': false,
    'kolektor': false,
    'elementHeating': false,
    'thermostat': false,
    'safetyValve': false,
    'kabelListrik': false,
    'pipa': false,
    'dinabolt': false,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInstallationItem('Tangki', 'tangki'),
        _buildInstallationItem('Kolektor', 'kolektor'),
        _buildInstallationItem('Element Heating', 'elementHeating'),
        _buildInstallationItem('Thermostat', 'thermostat'),
        _buildInstallationItem('Safety Valve', 'safetyValve'),
        _buildInstallationItem('Kabel / Listrik', 'kabelListrik'),
        _buildInstallationItem('Pipa', 'pipa'),
        _buildInstallationItem('Dinabolt', 'dinabolt'),
      ],
    );
  }

  Widget _buildInstallationItem(String label, String key) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Text(label),
        ),
        Radio<bool>(
          value: true,
          groupValue: installationStatus[key],
          onChanged: (value) => _updateStatus(key, true),
        ),
        const Text('Terpasang'),
        Radio<bool>(
          value: false,
          groupValue: installationStatus[key],
          onChanged: (value) => _updateStatus(key, false),
        ),
        const Text('Belum Terpasang'),
      ],
    );
  }

  void _updateStatus(String key, bool value) {
    setState(() {
      installationStatus[key] = value;
      widget.onChanged(installationStatus);
    });
  }
}