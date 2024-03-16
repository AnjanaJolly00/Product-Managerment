import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinetest/core/data/preferences/shared_preferences.dart';
import 'package:machinetest/features/auth/bloc/auth_event.dart';
import 'package:machinetest/features/auth/register_screen.dart';
import 'package:machinetest/features/auth/widgets/auth_form.dart';
import 'package:machinetest/features/pin_login/pin_screen.dart';
import 'package:machinetest/features/product_management/product_screen.dart';
import 'package:machinetest/shared/utils/app_colors.dart';
import 'package:machinetest/shared/utils/sharedprefs_key.dart';
import 'package:machinetest/shared/widgets/app_loader.dart';
import 'package:machinetest/shared/widgets/text_widget.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AppLoader loader = AppLoader();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeColor,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            loader.show(context);
          } else if (state is LoginSuccess) {
            loader.hide(context);

            if (SharedPrefs.getbool("pin") &&
                SharedPrefs.getbool(PrefConstants.isLoggedIn)) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProductScreen()),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const PinScreen()),
              );
            }
          } else if (state is LoginFailure) {
            loader.hide(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: context.read<AuthenticationBloc>(),
            builder: (context, state) {
              return AuthForm(
                  onTap: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                        LoginRequested(
                            email: userNameController.text,
                            password: passwordController.text));
                  },
                  password: passwordController,
                  subText: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => RegisterScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextWidget.mediumText(
                            text: 'Don\'t have an account? ',
                            color: AppColors.textColorLight,
                            fontSize: 16),
                        TextWidget.boldText(
                            text: 'Register',
                            color: AppColors.themeColor,
                            fontSize: 15)
                      ],
                    ),
                  ),
                  title: 'Login',
                  userName: userNameController);
            }),
      ),
    );
  }
}
