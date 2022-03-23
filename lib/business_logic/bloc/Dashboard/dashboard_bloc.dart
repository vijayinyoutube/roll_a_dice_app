import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc()
      : super(const DashboardInitial(score: 1, chancesLeft: 10, diceVal: 0)) {
    on<DashboardEvent>((event, emit) async {
      if (event is Rollice) {
        emit(DashboardLoading(
            chancesLeft: state.chancesLeft,
            diceVal: state.diceVal,
            score: state.score));
        await Future.delayed(const Duration(seconds: 1), () async {
          var diceValue = Random().nextInt(5) + 1;
          if (state.chancesLeft - 1 > 0) {
            emit(DashboardLoaded(
                diceVal: diceValue,
                chancesLeft: state.chancesLeft - 1,
                score: state.score + diceValue + 1));
          } else {
            emit(DashboardLoaded(
                diceVal: diceValue,
                chancesLeft: state.chancesLeft - 1,
                score: state.score + diceValue + 1));
            await Future.delayed(const Duration(seconds: 1), () async {});
            emit(DashboardLoading(
                chancesLeft: state.chancesLeft,
                diceVal: state.diceVal,
                score: state.score));
            emit(GameDone(
                diceVal: state.diceVal,
                chancesLeft: state.chancesLeft,
                score: state.score));
          }
        });
      } else if (event is Logout) {
        emit(DashboardLoading(
            score: state.score,
            diceVal: state.diceVal,
            chancesLeft: state.chancesLeft));
        await Future.delayed(const Duration(seconds: 3), () async {
          emit(LogoutState(
              score: state.score,
              diceVal: state.diceVal,
              chancesLeft: state.chancesLeft));
        });
      }
    });
  }
}
