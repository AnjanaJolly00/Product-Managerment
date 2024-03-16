import 'package:equatable/equatable.dart';

abstract class PinState extends Equatable {
  const PinState();

  @override
  List<Object> get props => [];
}

class PinInitial extends PinState {}

class PinLoading extends PinState {}

class PinSetSuccess extends PinState {}

class PinSetFailure extends PinState {
  final String error;

  const PinSetFailure(this.error);

  @override
  List<Object> get props => [error];
}

class PinVerificationSuccess extends PinState {}

class PinVerificationFailure extends PinState {
  final String error;

  const PinVerificationFailure(this.error);

  @override
  List<Object> get props => [error];
}
