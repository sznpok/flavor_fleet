import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repo/auth_repo.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepo authRepo;

  RegisterBloc({required this.authRepo}) : super(RegisterInitial()) {
    on<RegisterUserEvent>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      await authRepo.registerUser(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      log("Registered");
      emit(RegisterSuccess());
    } catch (error) {
      log(error.toString());
      emit(RegisterFailure(error: error.toString()));
    }
  }
}
