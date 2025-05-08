import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateAssignmentStartedAt implements UseCase<Assignment, NoParams> {
  final DashboardRepository repository;

  UpdateAssignmentStartedAt(this.repository);

  @override
  Future<Either<Failure, Assignment>> call(NoParams params) async {
    return await repository.updateAssignmentStartedAt();
  }
}
