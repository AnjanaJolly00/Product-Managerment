import 'package:equatable/equatable.dart';

abstract class PinEvent extends Equatable {
  const PinEvent();

  @override
  List<Object> get props => [];
}

class PinSetRequested extends PinEvent {
  final String pin;

  const PinSetRequested({required this.pin});

  @override
  List<Object> get props => [pin];
}

class PinVerificationRequested extends PinEvent {
  final String pin;

  const PinVerificationRequested({required this.pin});

  @override
  List<Object> get props => [pin];
}
