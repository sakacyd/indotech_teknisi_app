import 'package:indotech_teknisi_app/features/report/domain/entities/inspection_item.dart';

class InspectionItemModel extends InspectionItem {
  InspectionItemModel({
    required super.id,
    required super.reportId,
    super.itemName,
    super.condition,
    super.quantity,
    super.notes,
  });

  factory InspectionItemModel.fromJson(Map<String, dynamic> json) {
    return InspectionItemModel(
      id: json['id'] as String,
      reportId: json['report_id'] as String,
      itemName: json['item_name'] as String?,
      condition: json['condition'] as String?,
      quantity: json['quantity']?.toString(),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'report_id': reportId,
      'item_name': itemName,
      'condition': condition,
      'quantity': quantity,
      'notes': notes,
    };
  }

  InspectionItemModel copyWith({
    String? id,
    String? reportId,
    String? itemName,
    String? condition,
    String? quantity,
    String? notes,
  }) {
    return InspectionItemModel(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      itemName: itemName ?? this.itemName,
      condition: condition ?? this.condition,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
    );
  }
}
