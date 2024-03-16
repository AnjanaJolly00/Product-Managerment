import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinetest/features/auth/bloc/auth_event.dart';
import 'package:machinetest/features/auth/login_screen.dart';
import 'package:machinetest/features/auth/widgets/auth_form.dart';
import 'package:machinetest/shared/utils/app_colors.dart';
import 'package:machinetest/shared/widgets/app_loader.dart';
import 'package:machinetest/shared/widgets/text_widget.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/auth_state.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  final AppLoader loader = AppLoader();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeColor,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            loader.show(context);
          } else if (state is RegisterSuccess) {
            loader.hide(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    TextWidget.lightText(text: 'Please login to continue')));
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LoginScreen()));
          } else if (state is RegisterFailure) {
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
                        RegisterRequested(
                            email: userNameController.text,
                            password: passwordController.text,
                            password2: repeatPasswordController.text));
                  },
                  password: passwordController,
                  repeatPassword: repeatPasswordController,
                  subText: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => LoginScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextWidget.mediumText(
                            text: 'Already have an account? ',
                            color: AppColors.textColorLight,
                            fontSize: 16),
                        TextWidget.boldText(
                            text: 'Login',
                            color: AppColors.themeColor,
                            fontSize: 15)
                      ],
                    ),
                  ),
                  title: 'Register',
                  userName: userNameController);
            }),
      ),
    );
  }
}
