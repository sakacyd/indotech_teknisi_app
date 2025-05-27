import 'dart:io';

import 'package:indotech_teknisi_app/core/error/exceptions.dart';
import 'package:indotech_teknisi_app/features/report/data/models/assignment_model.dart';
import 'package:indotech_teknisi_app/features/report/data/models/report_model.dart';
import 'package:indotech_teknisi_app/features/report/data/models/installation_report_model.dart';
import 'package:indotech_teknisi_app/features/report/data/models/inspection_report_model.dart';
import 'package:indotech_teknisi_app/features/report/data/models/inspection_item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ReportRemoteDataSource {
  Future<ReportModel> updateTechnicianArrivedAt(String assignmentId);
  Future<ReportModel> updateAssignmentStartedAt(String assignmentId);
  Future<ReportModel> updateAssignmentFinishedAt(String assignmentId);
  Future<AssignmentModel> updateAssignmentStatus(String assignmentId);
  Future<ReportModel> getReportByAssignmentId(String assignmentId);
  Future<InstallationReportModel> uploadInstallationReport(
    InstallationReportModel installationReport,
  );
  Future<InspectionReportModel> uploadInspectionReport(
    InspectionReportModel inspectionReport,
  );
  Future<InspectionItemModel> uploadInspectionItem(
    InspectionItemModel inspectionItem,
  );
  Future<String> uploadInstallationReportImages({
    required File image,
    required InstallationReportModel installationReport,
    required String type,
  });
  Future<String> uploadInspectionReportImages({
    required File image,
    required InspectionReportModel inspectionReport,
    required String type,
  });
}

class ReportRemoteDataSourceImpl implements ReportRemoteDataSource {
  final SupabaseClient supabaseClient;

  ReportRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<ReportModel> updateTechnicianArrivedAt(String assignmentId) async {
    try {
      final now = DateTime.now().toIso8601String();

      final updatedReport =
          await supabaseClient
              .from('reports')
              .update({'technician_arrived_at': now})
              .eq('assignment_id', assignmentId)
              .select();

      return ReportModel.fromJson(updatedReport.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ReportModel> updateAssignmentStartedAt(String assignmentId) async {
    try {
      final now = DateTime.now().toIso8601String();

      final updatedReport =
          await supabaseClient
              .from('reports')
              .update({'assignment_started_at': now})
              .eq('assignment_id', assignmentId)
              .select();

      return ReportModel.fromJson(updatedReport.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ReportModel> updateAssignmentFinishedAt(String assignmentId) async {
    try {
      final now = DateTime.now().toIso8601String();

      final updatedReport =
          await supabaseClient
              .from('reports')
              .update({'assignment_finished_at': now})
              .eq('assignment_id', assignmentId)
              .select();

      return ReportModel.fromJson(updatedReport.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AssignmentModel> updateAssignmentStatus(String assignmentId) async {
    try {
      final updatedAssignment =
          await supabaseClient
              .from('assignments')
              .update({'status': 'Completed'})
              .eq('id', assignmentId)
              .select();

      return AssignmentModel.fromJson(updatedAssignment.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ReportModel> getReportByAssignmentId(String assignmentId) async {
    try {
      final res = await supabaseClient
          .from('reports')
          .select(
            '*, assignments(assignment_type(name), customers(name, phone_number, address), technicians(name, phone_number, address), unit, unit_quantity)',
          )
          .eq('assignment_id', assignmentId);

      return ReportModel.fromJson(res.first).copyWith(
        unit: res.first['assignments']['unit'],
        unitQuantity: res.first['assignments']['unit_quantity'],
        customerName: res.first['assignments']['customers']['name'],
        customerPhoneNumber:
            res.first['assignments']['customers']['phone_number'],
        customerAddress: res.first['assignments']['customers']['address'],
        technicianName: res.first['assignments']['technicians']['name'],
      );
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<InstallationReportModel> uploadInstallationReport(
    InstallationReportModel installationReport,
  ) async {
    try {
      final installationReportData =
          await supabaseClient
              .from('installation_reports')
              .insert(installationReport.toJson())
              .select();
      return InstallationReportModel.fromJson(installationReportData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadInstallationReportImages({
    required File image,
    required InstallationReportModel installationReport,
    required String type,
  }) async {
    try {
      final fileName = '${installationReport.id}_$type';
      await supabaseClient.storage
          .from('installation_report_images')
          .upload(fileName, image);
      return supabaseClient.storage
          .from('installation_report_images')
          .getPublicUrl(fileName);
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<InspectionReportModel> uploadInspectionReport(
    InspectionReportModel inspectionReport,
  ) async {
    try {
      final inspectionReportData =
          await supabaseClient
              .from('inspection_reports')
              .insert(inspectionReport.toJson())
              .select();
      return InspectionReportModel.fromJson(inspectionReportData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<InspectionItemModel> uploadInspectionItem(
    InspectionItemModel inspectionItem,
  ) async {
    try {
      final inspectionItemData =
          await supabaseClient
              .from('inspection_items')
              .insert(inspectionItem.toJson())
              .select();
      return InspectionItemModel.fromJson(inspectionItemData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadInspectionReportImages({
    required File image,
    required InspectionReportModel inspectionReport,
    required String type,
  }) async {
    try {
      final fileName = '${inspectionReport.id}_$type';
      await supabaseClient.storage
          .from('inspection_report_images')
          .upload(fileName, image);
      return supabaseClient.storage
          .from('inspection_report_images')
          .getPublicUrl(fileName);
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
