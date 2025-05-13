part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardGetAllSuccess extends DashboardState {
  final Assignment? assignments;
  final User user;

  DashboardGetAllSuccess(this.assignments, this.user);
}

final class DashboardFailure extends DashboardState {
  final String message;

  DashboardFailure(this.message);
}
