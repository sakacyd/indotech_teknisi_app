import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/usecase/usecase.dart';
import 'package:indotech_teknisi_app/core/common/entities/user.dart';
import 'package:indotech_teknisi_app/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUser implements UseCase<User, NoParams> {
  final DashboardRepository dashboardRepository;

  GetCurrentUser(this.dashboardRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await dashboardRepository.getCurrentUser();
  }
}
