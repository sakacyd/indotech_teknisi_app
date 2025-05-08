import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateTechnicianArrivedAt implements UseCase<Assignment, NoParams> {
  final DashboardRepository repository;

  UpdateTechnicianArrivedAt(this.repository);

  @override
  Future<Either<Failure, Assignment>> call(UpdateTechnicianArrivedAtParams params) async {
    return await repository.updateTechnicianArrivedAt(
      technicianArrivedAt: params.technicianArrivedAt,
    );
  }
}


class UpdateTechnicianArrivedAtParams {
  final DateTime technicianArrivedAt;

  UpdateTechnicianArrivedAtParams({required this.technicianArrivedAt});
}
