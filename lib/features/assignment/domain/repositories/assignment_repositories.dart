import 'dart:io';

import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AssignmentRepository {
  Future<Either<Failure, List<Assignment>>> getTodayAssignments();
  Future<Either<Failure, List<Assignment>>> getPreviousAssignments();
}
