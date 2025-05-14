import 'dart:io';

import 'package:flutter/material.dart';
import 'package:indotech_teknisi_app/core/error/exceptions.dart';
import 'package:indotech_teknisi_app/features/assignment/data/models/assignment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AssignmentRemoteDataSource {
  Future<List<AssignmentModel>> getTodayAssignments();
  Future<List<AssignmentModel>> getPreviousAssignments();
}

class AssignmentRemoteDataSourceImpl implements AssignmentRemoteDataSource {
  final SupabaseClient supabaseClient;
  final now = DateTime.now();

  AssignmentRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<AssignmentModel>> getTodayAssignments() async {
    try {
      final startOfDay = DateTime.now().toIso8601String();
      final endOfDay =
          DateTime(now.year, now.month, now.day, 23, 59, 59).toIso8601String();

      final res = await supabaseClient
          .from('assignments')
          .select(
            '*, assignment_type(name), customers(name, phone_number, address)',
          )
          .eq('technician_id', supabaseClient.auth.currentSession!.user.id)
          .eq('status', 'Pending')
          .gte('scheduled_at', startOfDay)
          .lte('scheduled_at', endOfDay)
          .order('scheduled_at', ascending: true);

      return res
          .map(
            (assignment) => AssignmentModel.fromJson(assignment).copyWith(
              assignmentTypeName: assignment['assignment_type']['name'],
              customerName: assignment['customers']['name'],
              customerPhoneNumber: assignment['customers']['phone_number'],
              customerAddress: assignment['customers']['address'],
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<AssignmentModel>> getPreviousAssignments() async {
    try {
      final now = DateTime.now().toIso8601String();

      final technicianId = supabaseClient.auth.currentSession!.user.id;

      // 1. Dapatkan assignment scheduled_at <= now
      final resBeforeNow = await supabaseClient
          .from('assignments')
          .select(
            '*, assignment_type(name), customers(name, phone_number, address)',
          )
          .eq('technician_id', technicianId)
          .lte('scheduled_at', now);

      // 2. Dapatkan assignment scheduled_at > now dan status == 'Completed'
      final resCompletedFuture = await supabaseClient
          .from('assignments')
          .select(
            '*, assignment_type(name), customers(name, phone_number, address)',
          )
          .eq('technician_id', technicianId)
          .gt('scheduled_at', now)
          .eq('status', 'Completed');

      // Gabungkan hasil
      final allResults = [...resBeforeNow, ...resCompletedFuture];

      // Urutkan berdasarkan scheduled_at menurun (desc)
      allResults.sort(
        (a, b) => DateTime.parse(
          b['scheduled_at'],
        ).compareTo(DateTime.parse(a['scheduled_at'])),
      );

      return allResults
          .map(
            (assignment) => AssignmentModel.fromJson(assignment).copyWith(
              assignmentTypeName: assignment['assignment_type']['name'],
              customerName: assignment['customers']['name'],
              customerPhoneNumber: assignment['customers']['phone_number'],
              customerAddress: assignment['customers']['address'],
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
