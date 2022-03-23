part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class NavBack extends DashboardEvent {}

class Rollice extends DashboardEvent {
  final String userName;
  Rollice(this.userName);
}

class Logout extends DashboardEvent {}

class RestartGame extends DashboardEvent {}
