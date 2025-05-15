import 'package:indotech_teknisi_app/core/error/exceptions.dart';
import 'package:indotech_teknisi_app/features/report/data/models/assignment_model.dart';
import 'package:indotech_teknisi_app/features/report/data/models/report_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ReportRemoteDataSource {
  Future<ReportModel> updateTechnicianArrivedAt(String assignmentId);
  Future<ReportModel> updateAssignmentStartedAt(String assignmentId);
  Future<ReportModel> updateAssignmentFinishedAt(String assignmentId);
  Future<AssignmentModel> updateAssignmentStatus(String assignmentId);
  Future<ReportModel> getReportByAssignmentId(String assignmentId);
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
          .select('*, assignments(assignment_type(id, name), customers(name, phone_number, address), technicians(name, phone_number, address))')
          .eq('assignment_id', assignmentId);

      return ReportModel.fromJson(res.first).copyWith(
          unit: res.first['unit'],
          unitQuantity: res.first['unit_quantity'],
          customerName: res.first['customer_name'],
          customerPhoneNumber: res.first['customer_phone_number'],
          customerAddress: res.first['customer_address'],
        );
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
