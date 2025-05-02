import 'dart:async';
import 'package:indotech_teknisi_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';
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
  final AppUserCubit _appUserCubit;
  DashboardBloc({
    required GetNearestAssignment getNearestAssignment,
    required GetCurrentUser getCurrentUser,
    required AppUserCubit appUserCubit,
  }) : _getNearestAssignment = getNearestAssignment,
       _getCurrentUser = getCurrentUser,
       _appUserCubit = appUserCubit,
       super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) => emit(DashboardLoading()));
    on<FetchNearestAssignment>(_onAllAssignmentsRequested);
    on<FetchTechnician>(_onTechnicianRequested);
  }

  FutureOr<void> _onAllAssignmentsRequested(
    FetchNearestAssignment event,
    Emitter<DashboardState> emit,
  ) async {
    final res = await _getNearestAssignment(NoParams());

    res.fold(
      (l) => emit(DashboardFailure(l.message)),
      (r) => emit(DashboardGetAllSuccess(r)),
    );
  }

  FutureOr<void> _onTechnicianRequested(
    FetchTechnician event,
    Emitter<DashboardState> emit,
  ) async {
    final res = await _getCurrentUser(NoParams());

    res.fold((l) {
      emit(DashboardFailure(l.message));
    }, (r) => _emitDashboardSuccess(r, emit));
  }

  void _emitDashboardSuccess(
    List<Assignment> assignments,
    User user,
    Emitter<DashboardState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(DashboardGetAllSuccess(assignments, user));
  }
}
