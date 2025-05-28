import 'package:indotech_teknisi_app/features/report/domain/entities/inspection_item.dart';

class InspectionItemModel extends InspectionItem {
  InspectionItemModel({
    required super.id,
    required super.inspectionReportId,
    super.itemName,
    super.condition,
    super.quantity,
    super.notes,
  });

  factory InspectionItemModel.fromJson(Map<String, dynamic> json) {
    return InspectionItemModel(
      id: json['id'] as String,
      inspectionReportId: json['inspection_report_id'] as String,
      itemName: json['item_name'] as String?,
      condition: json['condition'] as String?,
      quantity: json['quantity'] as int?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'inspection_report_id': inspectionReportId,
      'item_name': itemName,
      'condition': condition,
      'quantity': quantity,
      'notes': notes,
    };
  }

  InspectionItemModel copyWith({
    String? id,
    String? inspectionReportId,
    String? itemName,
    String? condition,
    int? quantity,
    String? notes,
  }) {
    return InspectionItemModel(
      id: id ?? this.id,
      inspectionReportId: inspectionReportId ?? this.inspectionReportId,
      itemName: itemName ?? this.itemName,
      condition: condition ?? this.condition,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
    );
  }
}
