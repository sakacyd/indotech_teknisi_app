import 'dart:async';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';
import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/features/dashboard/domain/usecases/get_nearest_assignments.dart';
import 'package:indotech_teknisi_app/features/dashboard/domain/usecases/get_current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetNearestAssignment _getNearestAssignment;
  final GetCurrentUser _getCurrentUser;
  DashboardBloc({
    required GetNearestAssignment getNearestAssignment,
    required GetCurrentUser getCurrentUser,
  }) : _getNearestAssignment = getNearestAssignment,
       _getCurrentUser = getCurrentUser,
       super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) => emit(DashboardLoading()));
    on<FetchDashboardData>(_onDashboardDataRequested);
  }

  FutureOr<void> _onDashboardDataRequested(
    FetchDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    final technicianResult = await _getCurrentUser(NoParams());
    final assignmentResult = await _getNearestAssignment(NoParams());

    if (technicianResult.isLeft()) {
      final failure = technicianResult.swap().getOrElse(
        (_) => Failure('Unknown error'),
      );
      emit(DashboardFailure(failure.message));
      return;
    }

    final technician = technicianResult.getOrElse(
      (_) => throw Exception('Missing user'),
    );

    final assignment = assignmentResult.fold<Assignment?>((failure) {
      return null;
    }, (data) => data);

    emit(DashboardGetAllSuccess(assignment, technician));
  }
}
