class InspectionItem {
  final String id;
  final String reportId;
  final String? itemName;
  final String? condition;
  final String? quantity;
  final String? notes;

  InspectionItem({
    required this.id,
    required this.reportId,
    this.itemName,
    this.condition,
    this.quantity,
    this.notes,
  });
}
