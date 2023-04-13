import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_app/features/domain/entities/user_entity.dart';
import 'package:location_app/features/domain/use_cases/sign_in_usecase.dart';
import 'package:location_app/features/domain/use_cases/sign_up_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignUpUseCase signUpUseCase = SignUpUseCase();
  final SignInUseCase signInUseCase = SignInUseCase();

  CredentialCubit() : super(CredentialInitial());

  Future<void> signInSubmit({
    required String email,
    required String password,
  }) async {
    emit(CredentialLoading());
    try {
      await signInUseCase.call(UserEntity(email: email, password: password));
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUpSubmit({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase
          .call(UserEntity(email: user.email, password: user.password));
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
