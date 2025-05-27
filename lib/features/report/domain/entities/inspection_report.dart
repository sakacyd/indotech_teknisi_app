class InspectionReport {
  final String id;
  final int reportId;
  final DateTime date;
  final String tankSerialNumber;
  final String collectorSerialNumber;
  final String isUnderWarranty;
  final String remarks;
  final String? notes;
  final String technicianSignatureUrl;
  final String customerSignatureUrl;

  InspectionReport({
    required this.id,
    required this.reportId,
    required this.date,
    required this.tankSerialNumber,
    required this.collectorSerialNumber,
    required this.isUnderWarranty,
    required this.remarks,
    this.notes,
    required this.technicianSignatureUrl,
    required this.customerSignatureUrl,
  });
}
