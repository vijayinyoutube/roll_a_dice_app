import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Data/Repository/Firebase/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is Login) {
        if (event.userName.isEmpty || event.password.isEmpty) {
          emit(AuthError());
        } else {
          emit(AuthLoading());
          await Future.delayed(const Duration(seconds: 3), () async {
            bool isAuthenticated =
                await Authentication().signUp(event.userName, event.password);

            isAuthenticated
                ? emit(AuthLoaded(event.userName))
                : emit(AuthError());
          });
        }
      }
    });
  }
}
