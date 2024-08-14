import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends RegisterEvent {
  final String name;
  final String username;
  final String email;
  final String password;

  const RegisterUserEvent({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, username, email, password];
}
