// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/constants/constants.dart';
import 'package:indotech_teknisi_app/core/error/exceptions.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';
import 'package:indotech_teknisi_app/core/network/connection_checker.dart';
import 'package:indotech_teknisi_app/features/dashboard/data/models/assignment_model.dart';
import 'package:indotech_teknisi_app/features/dashboard/data/models/technician_model.dart';
import 'package:fpdart/fpdart.dart';

import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:indotech_teknisi_app/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:uuid/uuid.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource dashboardRemoteDataSource;
  final ConnectionChecker connectionChecker;
  const DashboardRepositoryImpl(
    this.dashboardRemoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = dashboardRemoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure('User not logged in!'));
        }

        return right(
          TechnicianModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: /* session.user.userMetadata['name'] ??  */ '',
            imageUrl: /* session.user.userMetadata['image_url'] ??  */ '',
            phoneNumber: /* session.user.userMetadata['phone_number'] ?? */ '',
            address: /* session.user.userMetadata['address'] ?? */ '',
            bloodType: /* session.user.userMetadata['blood_type'] ?? */ '',
          ),
        );
      }

      final user = await dashboardRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not logged in!'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Assignment>> getNearestAssignment() async {
    try {
      final assignment = await dashboardRemoteDataSource.getNearestAssignment();
      return right(assignment);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  /* @override
  Future<Either<Failure, Assignment>> updateTechnicianArrivedAt({
    required AssignmentModel assignment,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionMessage));
      }
      final updatedAssignment = await dashboardRemoteDataSource.updateTechnicianArrivedAt(assignment);
      return right(updatedAssignment);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Assignment>> updateAssignmentStartedAt({
    required AssignmentModel assignment,
  }) async {
    try {
      final updatedAssignment =
          await dashboardRemoteDataSource.updateAssignmentStartedAt(assignment);
      return right(updatedAssignment);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Assignment>> updateAssignmentFinishedAt({
    required AssignmentModel assignment,
  }) async {
    try {
      final updatedAssignment =
          await dashboardRemoteDataSource.updateAssignmentFinishedAt(assignment);
      return right(updatedAssignment);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  } */
}
