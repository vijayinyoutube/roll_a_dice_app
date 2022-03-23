part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {
  final int diceVal;
  final int chancesLeft;
  final int score;
  const DashboardState({
    required this.score,
    required this.diceVal,
    required this.chancesLeft,
  });
}

class DashboardInitial extends DashboardState {
  const DashboardInitial(
      {required int score, required int diceVal, required int chancesLeft})
      : super(score: score, diceVal: diceVal, chancesLeft: chancesLeft);
}

class DashboardLoading extends DashboardState {
  const DashboardLoading(
      {required int score, required int diceVal, required int chancesLeft})
      : super(score: score, diceVal: diceVal, chancesLeft: chancesLeft);
}

class DashboardLoaded extends DashboardState {
  const DashboardLoaded(
      {required int score, required int diceVal, required int chancesLeft})
      : super(score: score, diceVal: diceVal, chancesLeft: chancesLeft);
}

class GameDone extends DashboardState {
  const GameDone(
      {required int score, required int diceVal, required int chancesLeft})
      : super(score: score, diceVal: diceVal, chancesLeft: chancesLeft);
}

class LogoutState extends DashboardState {
  const LogoutState(
      {required int score, required int diceVal, required int chancesLeft})
      : super(score: score, diceVal: diceVal, chancesLeft: chancesLeft);
}
