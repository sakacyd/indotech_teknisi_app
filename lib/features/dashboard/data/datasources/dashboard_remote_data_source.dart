import 'package:indotech_teknisi_app/core/error/exceptions.dart';
import 'package:indotech_teknisi_app/features/dashboard/data/models/assignment_model.dart';
import 'package:indotech_teknisi_app/features/dashboard/data/models/technician_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class DashboardRemoteDataSource {
  Session? get currentUserSession;
  Future<TechnicianModel?> getCurrentUserData();
  Future<AssignmentModel> getNearestAssignment();
  Future<AssignmentModel> updateTechnicianArrivedAt();
  Future<AssignmentModel> updateAssignmentStartedAt();
  Future<AssignmentModel> updateAssignmentFinishedAt();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final SupabaseClient supabaseClient;

  DashboardRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<TechnicianModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('technicians')
            .select()
            .eq('id', currentUserSession!.user.id);
        return TechnicianModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
          name: userData.first['name'],
          imageUrl: userData.first['image_url'],
          phoneNumber: userData.first['phone_number'],
          address: userData.first['address'],
          bloodType: userData.first['blood_type'],
        );
      }
      return null;
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AssignmentModel> getNearestAssignment() async {
    try {
      final now = DateTime.now().toIso8601String();

      final res = await supabaseClient
          .from('assignments')
          .select(
            '*, assignment_type(name),customers(name, phone_number, address), technicians(name, phone_number, address)',
          )
          .eq('technician_id', supabaseClient.auth.currentSession!.user.id)
          .gte('scheduled_at', now)
          .order('scheduled_at', ascending: true)
          .limit(1);

      return AssignmentModel.fromJson(res.first).copyWith(
        assignmentTypeName: res.first['assignment_type']['name'],
        customerName: res.first['customers']['name'],
        customerPhoneNumber: res.first['customers']['phone_number'],
        customerAddress: res.first['customers']['address'],
        technicianName: res.first['technicians']['name'],
        technicianPhoneNumber: res.first['technicians']['phone_number'],
        technicianAddress: res.first['technicians']['address'],
      );
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AssignmentModel> updateTechnicianArrivedAt(
    AssignmentModel assignment,
  ) async {
    try {
      final now = DateTime.now().toIso8601String();

      final updatedAssignment =
          await supabaseClient
              .from('assignments')
              .update({'technician_arrived_at': now})
              .eq('id', assignment.id)
              .select();

      return AssignmentModel.fromJson(updatedAssignment.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AssignmentModel> updateAssignmentStartedAt(
    AssignmentModel assignment,
  ) async {
    try {
      final now = DateTime.now().toIso8601String();

      final updatedAssignment =
          await supabaseClient
              .from('assignments')
              .update({'assignment_started_at': now})
              .eq('id', assignment.id)
              .select();

      return AssignmentModel.fromJson(updatedAssignment.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AssignmentModel> updateAssignmentFinishedAt(
    AssignmentModel assignment,
  ) async {
    try {
      final now = DateTime.now().toIso8601String();

      final updatedAssignment =
          await supabaseClient
              .from('assignments')
              .update({'assignment_finished_at': now})
              .eq('id', assignment.id)
              .select();

      return AssignmentModel.fromJson(updatedAssignment.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
