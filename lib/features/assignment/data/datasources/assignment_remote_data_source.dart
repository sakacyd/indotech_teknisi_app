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
      final startOfDay =
          DateTime(now.year, now.month, now.day).toIso8601String();
      final endOfDay =
          DateTime(now.year, now.month, now.day, 23, 59, 59).toIso8601String();

      final res = await supabaseClient
          .from('assignments')
          .select('*, customers(name, phone_number, address)')
          .eq('technician_id', supabaseClient.auth.currentSession!.user.id)
          .gte('scheduled_at', startOfDay)
          .lte('scheduled_at', endOfDay)
          .order('scheduled_at', ascending: true);

      return res
          .map(
            (assignment) => AssignmentModel.fromJson(assignment).copyWith(
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
      final startOfDay =
          DateTime(now.year, now.month, now.day).toIso8601String();

      final res = await supabaseClient
          .from('assignments')
          .select('*, customers(name, phone_number, address)')
          .eq('technician_id', supabaseClient.auth.currentSession!.user.id)
          .lt('scheduled_at', startOfDay)
          .order('scheduled_at', ascending: false);

      return res
          .map(
            (assignment) => AssignmentModel.fromJson(assignment).copyWith(
              assignmentType: assignment['customers']['name'],
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
