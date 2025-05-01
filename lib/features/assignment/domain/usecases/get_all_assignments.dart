import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/features/assignment/domain/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/assignment/domain/repositories/assignment_repositories.dart';
import 'package:fpdart/fpdart.dart';

class GetAllAssignments implements UseCase<List<Assignment>, NoParams> {
  final AssignmentRepository repository;

  GetAllAssignments(this.repository);

  @override
  Future<Either<Failure, List<Assignment>>> call(NoParams params) async {
    return await repository.getAllAssignments();
  }
}