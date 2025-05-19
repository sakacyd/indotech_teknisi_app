import 'package:flutter/material.dart';

class InstallationStatusWidget extends StatefulWidget {
  final Function(Map<String, bool>) onChanged;

  const InstallationStatusWidget({super.key, required this.onChanged});

  @override
  State<InstallationStatusWidget> createState() =>
      _InstallationStatusWidgetState();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: installationStatus[key],
                        onChanged: (value) => _updateStatus(key, true),
                      ),
                      const Text('Terpasang'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<bool>(
                        value: false,
                        groupValue: installationStatus[key],
                        onChanged: (value) => _updateStatus(key, false),
                      ),
                      const Text('Belum Terpasang'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(height: 1, color: Colors.grey[300], thickness: 1),
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
