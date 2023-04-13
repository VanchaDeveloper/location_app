import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_app/features/domain/use_cases/is_sign_in_usecase.dart';
import 'package:location_app/features/domain/use_cases/sign_out_usecase.dart';
import 'package:location_app/features/presentation/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase = IsSignInUseCase();
  final SignOutUseCase signOutUseCase = SignOutUseCase();

  AuthCubit() : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      bool isSignIn = await isSignInUseCase.call();
      if (isSignIn == true) {
        emit(Authenticated());
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      emit(Authenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase.call();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
