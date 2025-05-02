import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class DashboardRepository {
  Future<Either<Failure, List<Assignment>>> getNearestAssignment();

  Future<Either<Failure, User>> currentUser();
}
