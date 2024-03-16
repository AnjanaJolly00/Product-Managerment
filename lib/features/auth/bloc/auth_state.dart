import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

// Login States
class LoginLoading extends AuthenticationState {}

class LoginSuccess extends AuthenticationState {
  final User user;

  const LoginSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class LoginFailure extends AuthenticationState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

// Register States
class RegisterLoading extends AuthenticationState {}

class RegisterSuccess extends AuthenticationState {
  final User user;

  const RegisterSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class RegisterFailure extends AuthenticationState {
  final String error;

  const RegisterFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

// Logout States
class LogoutLoading extends AuthenticationState {}

class LogoutSuccess extends AuthenticationState {}

class LogoutFailure extends AuthenticationState {
  final String error;

  const LogoutFailure({required this.error});

  @override
  List<Object?> get props => [error];
}



