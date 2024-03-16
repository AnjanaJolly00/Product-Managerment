import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:machinetest/core/data/preferences/shared_preferences.dart';
import 'package:machinetest/shared/utils/app_utils.dart';
import 'package:machinetest/shared/utils/sharedprefs_key.dart';
import '../../../core/data/models/api_response.dart';
import '../../../core/data/repository/auth_repo.dart';
import '../../../core/data/repository/pin_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({required this.authenticationRepository})
      : super(AuthenticationInitial()) {
    on<LoginRequested>(onLogin);
    on<RegisterRequested>(onRegister);
    on<LogoutRequested>(onLogOut);
  }

  bool _isPinSet = false;
  bool _hideLoginpassword = true;
  bool get hideLoginPassword => _hideLoginpassword;

  toggleLoginPassword() {
    _hideLoginpassword = !hideLoginPassword;
  }

  Future<void> onRegister(RegisterRequested event, Emitter emit) async {
    emit(RegisterLoading());
    if (!isEmail(event.email.trim())) {
      emit(const RegisterFailure(error: 'Invalid email'));
    } else if (!isPassword(event.password.trim())) {
      emit(const RegisterFailure(
          error: 'Password should contain atleast 8 characters'));
    } else if (event.password.trim() != event.password2.trim()) {
      emit(const RegisterFailure(error: 'Password mismatch'));
    } else {
      ApiResponse<UserCredential> res =
          await authenticationRepository.registerWithEmailAndPassword(
              event.email.trim(), event.password.trim());
      SharedPrefs.setbool("pin", false);
      const FlutterSecureStorage().deleteAll();
      if (res.rawResponse != null) {
        emit(RegisterSuccess(user: res.rawResponse!.user!));
      } else {
        emit(RegisterFailure(error: res.errorMsg.toString()));
      }
    }
  }

  Future<void> onLogin(LoginRequested event, Emitter emit) async {
    emit(LoginLoading());
    if (!isEmail(event.email.trim())) {
      emit(const LoginFailure(error: 'Invalid email'));
    } else {
      ApiResponse<UserCredential> res =
          await authenticationRepository.signInWithEmailAndPassword(
              event.email.trim(), event.password.trim());

      if (res.rawResponse != null) {
        await checkPin();
        emit(LoginSuccess(user: res.rawResponse!.user!));

        SharedPrefs.setbool(PrefConstants.isLoggedIn, true);
        SharedPrefs.setString(
            PrefConstants.userName, res.rawResponse!.user!.displayName ?? "");
      } else {
        emit(LoginFailure(error: res.errorMsg.toString()));
      }
    }
  }

  Future checkPin() async {
    final pin = await PinRepository().getPinFromFirestore();
    _isPinSet = (pin != null);
    SharedPrefs.setbool("pin", _isPinSet);
  }

  Future<void> onLogOut(LogoutRequested event, Emitter emit) async {
    emit(LogoutLoading());

    var res = await authenticationRepository.signOut();
    if (res.isSuccessful) {
      SharedPrefs.setbool(PrefConstants.isLoggedIn, false);
      SharedPrefs.setbool(PrefConstants.pin, false);
      emit(LogoutSuccess());
    } else {
      emit(LogoutFailure(error: res.errorMsg.toString()));
    }
  }
}
