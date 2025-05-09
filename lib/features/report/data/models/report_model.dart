import 'package:indotech_teknisi_app/core/common/entities/user.dart';

class ReportModel extends User {
  ReportModel({
    required super.id,
    required super.name,
    required super.email,
    required super.imageUrl,
    required super.phoneNumber,
    required super.address,
    required super.bloodType,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      imageUrl: json['image_url'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      address: json['address'] ?? '',
      bloodType: json['blood_type'] ?? '',
    );
  }

  ReportModel copyWith({
    String? id,
    String? name,
    String? email,
    String? imageUrl,
    String? phoneNumber,
    String? address,
    String? bloodType,
  }) {
    return ReportModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      bloodType: bloodType ?? this.bloodType,
    );
  }
}
