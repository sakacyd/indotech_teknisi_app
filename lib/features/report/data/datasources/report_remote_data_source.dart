import 'package:indotech_teknisi_app/core/error/exceptions.dart';
import 'package:indotech_teknisi_app/features/report/data/models/report_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ReportRemoteDataSource {
  Future<ReportModel> updateTechnicianArrivedAt(ReportModel report);
  Future<ReportModel> updateAssignmentStartedAt(ReportModel report);
  Future<ReportModel> updateAssignmentFinishedAt(ReportModel report);
}

class ReportRemoteDataSourceImpl implements ReportRemoteDataSource {
  final SupabaseClient supabaseClient;

  ReportRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<ReportModel> updateTechnicianArrivedAt(ReportModel report) async {
    try {
      final now = DateTime.now().toIso8601String();

      final updatedReport =
          await supabaseClient
              .from('reports')
              .update({'technician_arrived_at': now})
              .eq('id', report.id)
              .select();

      return ReportModel.fromJson(updatedReport.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ReportModel> updateAssignmentStartedAt(ReportModel report) async {
    try {
      final now = DateTime.now().toIso8601String();

      final updatedReport =
          await supabaseClient
              .from('reports')
              .update({'assignment_started_at': now})
              .eq('id', report.id)
              .select();

      return ReportModel.fromJson(updatedReport.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ReportModel> updateAssignmentFinishedAt(ReportModel report) async {
    try {
      final now = DateTime.now().toIso8601String();

      final updatedReport =
          await supabaseClient
              .from('reports')
              .update({'assignment_finished_at': now})
              .eq('id', report.id)
              .select();

      return ReportModel.fromJson(updatedReport.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
