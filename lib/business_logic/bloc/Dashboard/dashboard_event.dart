part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class NavBack extends DashboardEvent {}

class Rollice extends DashboardEvent {}

class Logout extends DashboardEvent {}
