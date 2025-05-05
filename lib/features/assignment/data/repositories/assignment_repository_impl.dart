import 'dart:io';

import 'package:indotech_teknisi_app/core/constants/constants.dart';
import 'package:indotech_teknisi_app/core/error/exceptions.dart';
import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/network/connection_checker.dart';
import 'package:indotech_teknisi_app/features/assignment/data/datasources/assignment_local_data_source.dart';
import 'package:indotech_teknisi_app/features/assignment/data/datasources/assignment_remote_data_source.dart';
import 'package:indotech_teknisi_app/features/assignment/data/models/assignment_model.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/assignment/domain/repositories/assignment_repositories.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class AssignmentRepositoryImpl implements AssignmentRepository {
  final AssignmentRemoteDataSource assignmentRemoteDataSource;
  final AssignmentLocalDataSource assignmentLocalDataSource;
  final ConnectionChecker connectionChecker;

  AssignmentRepositoryImpl(
    this.assignmentRemoteDataSource,
    this.assignmentLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, List<Assignment>>> getTodayAssignments() async {
    try {
      var assignments = <AssignmentModel>[];
      if (!await connectionChecker.isConnected) {
        assignments = assignmentLocalDataSource.getLastAssignments();
      } else {
        assignments = await assignmentRemoteDataSource.getTodayAssignments();
        assignmentLocalDataSource.cacheAssignments(assignments);
      }
      return right(assignments);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Assignment>>> getPreviousAssignments() async {
    try {
      var assignments = <AssignmentModel>[];
      if (!await connectionChecker.isConnected) {
        assignments = assignmentLocalDataSource.getLastAssignments();
      } else {
        assignments = await assignmentRemoteDataSource.getPreviousAssignments();
        assignmentLocalDataSource.cacheAssignments(assignments);
      }
      return right(assignments);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
