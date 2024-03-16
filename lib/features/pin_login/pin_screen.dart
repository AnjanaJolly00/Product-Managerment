import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:machinetest/core/data/preferences/shared_preferences.dart';
import 'package:machinetest/core/data/repository/pin_repo.dart';
import 'package:machinetest/features/pin_login/bloc/pin_state.dart';
import 'package:machinetest/features/product_management/product_screen.dart';
import 'package:machinetest/shared/utils/app_colors.dart';
import 'package:machinetest/shared/utils/sharedprefs_key.dart';
import 'package:machinetest/shared/widgets/app_loader.dart';
import 'package:machinetest/shared/widgets/main_button.dart';
import 'package:machinetest/shared/widgets/text_widget.dart';
import 'bloc/pin_bloc.dart';
import 'bloc/pin_events.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: TextWidget.mediumText(
            text: (SharedPrefs.getbool(PrefConstants.pin) &&
                    SharedPrefs.getbool(PrefConstants.isLoggedIn))
                ? "Verify"
                : "Set Pin",
            color: AppColors.white),
      ),
      body: BlocProvider(
        create: (context) => PinBloc(pinRepository: PinRepository()),
        child: const PinForm(),
      ),
    );
  }
}

class PinForm extends StatefulWidget {
  const PinForm({super.key});

  @override
  _PinFormState createState() => _PinFormState();
}

class _PinFormState extends State<PinForm> {
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PinBloc, PinState>(
      listener: (context, state) {
        AppLoader loader = AppLoader();
        if (state is PinLoading) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            loader.show(context);
          });
        }
        if (state is PinSetSuccess || state is PinVerificationSuccess) {
          loader.hide(context);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => ProductScreen(),
          ));
        } else if (state is PinSetFailure) {
          loader.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: TextWidget.mediumText(text: state.error)),
          );
        } else if (state is PinVerificationFailure) {
          loader.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: TextWidget.mediumText(text: state.error)),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OtpTextField(
              numberOfFields: 5,
              fieldWidth: 60,
              borderColor: AppColors.borderColor,
              focusedBorderColor: AppColors.borderColor,
              showFieldAsBox: true,
              onSubmit: (String verificationCode) {
                _pinController.text = verificationCode;
              },
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 200,
              child: MainButton(
                onTap: () {
                  if (SharedPrefs.getbool(PrefConstants.pin) &&
                      SharedPrefs.getbool(PrefConstants.isLoggedIn)) {
                    BlocProvider.of<PinBloc>(context).add(
                        PinVerificationRequested(pin: _pinController.text));
                  } else {
                    if (_pinController.text.length == 5) {
                      BlocProvider.of<PinBloc>(context)
                          .add(PinSetRequested(pin: _pinController.text));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextWidget.mediumText(
                              text: 'Please enter a 5-digit PIN.'),
                        ),
                      );
                    }
                  }
                },
                text: (SharedPrefs.getbool(PrefConstants.pin) &&
                        SharedPrefs.getbool(PrefConstants.isLoggedIn))
                    ? "Verify"
                    : "Set Pin",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
