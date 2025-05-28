class InspectionItem {
  final String id;
  final String inspectionReportId;
  final String? itemName;
  final String? condition;
  final int? quantity;
  final String? notes;

  InspectionItem({
    required this.id,
    required this.inspectionReportId,
    this.itemName,
    this.condition,
    this.quantity,
    this.notes,
  });

  // Tambahkan ini
  InspectionItem copyWith({
    String? id,
    String? inspectionReportId,
    String? itemName,
    String? condition,
    int? quantity,
    String? notes,
  }) {
    return InspectionItem(
      id: id ?? this.id,
      inspectionReportId: inspectionReportId ?? this.inspectionReportId,
      itemName: itemName ?? this.itemName,
      condition: condition ?? this.condition,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
    );
  }
}
