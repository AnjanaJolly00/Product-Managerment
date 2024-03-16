import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:machinetest/core/data/preferences/shared_preferences.dart';
import 'package:machinetest/shared/utils/sharedprefs_key.dart';
import '../../../core/data/repository/pin_repo.dart';
import 'pin_events.dart';
import 'pin_state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  final PinRepository pinRepository;

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  PinBloc({required this.pinRepository}) : super(PinInitial()) {
    on<PinSetRequested>(setPin);
    on<PinVerificationRequested>(verifyPin);
  }
  Future<void> setPin(PinSetRequested event, Emitter emit) async {
    try {
      await pinRepository.storePinInFirestore(event.pin);
      SharedPrefs.setbool(PrefConstants.pin, true);
      SharedPrefs.setbool(PrefConstants.pin, false);
      emit(PinSetSuccess());
    } catch (e) {
      emit(const PinSetFailure('Failed to set Pin, Please try again!'));
    }
  }

  Future<void> verifyPin(PinVerificationRequested event, Emitter emit) async {
    emit(PinLoading());
    try {
      var storedPin = await pinRepository.getPinFromFirestore();
      if (event.pin == storedPin) {
        emit(PinVerificationSuccess());
        SharedPrefs.setbool(PrefConstants.pin, true);
      } else {
        SharedPrefs.setbool(PrefConstants.pin, false);
        emit(const PinVerificationFailure('Incorrect PIN. Please try again.'));
      }
    } catch (e) {
      SharedPrefs.setbool(PrefConstants.pin, false);
      emit(const PinVerificationFailure(
          'Failed to verify PIN. Please try again.'));
    }
  }
}
