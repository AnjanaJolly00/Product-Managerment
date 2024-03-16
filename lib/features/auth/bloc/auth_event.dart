import 'package:equatable/equatable.dart';

// Define authentication events
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthenticationEvent {
  final String email;
  final String password;
  final String password2;

  const RegisterRequested(
      {required this.email, required this.password, required this.password2});

  @override
  List<Object?> get props => [email, password];
}

class LogoutRequested extends AuthenticationEvent {}
