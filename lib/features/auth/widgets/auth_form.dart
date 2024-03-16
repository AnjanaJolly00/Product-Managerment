import 'package:flutter/material.dart';
import '../../../shared/utils/app_colors.dart';
import '../../../shared/widgets/common_textfield.dart';
import '../../../shared/widgets/main_button.dart';
import '../../../shared/widgets/text_widget.dart';

class AuthForm extends StatelessWidget {
  final String title;
  final TextEditingController userName;
  final TextEditingController password;
  final TextEditingController? repeatPassword;
  final void Function()? onTap;
  final bool isObscurePass1;
  final bool isObscurePass2;
  final Widget subText;
  const AuthForm(
      {super.key,
      required this.onTap,
      required this.password,
      required this.subText,
      required this.title,
      this.isObscurePass1 = true,
      this.isObscurePass2 = true,
      this.repeatPassword,
      required this.userName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 18, right: 18),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget.boldText(
                  text: title, fontSize: 18, color: AppColors.themeColor),
              const SizedBox(
                height: 10,
              ),
              CommonTextField(
                hintText: '',
                controller: userName,
              ),
              const SizedBox(
                height: 10,
              ),
              CommonTextField(
                hintText: '',
                controller: password,
                obsecureText: isObscurePass1,
              ),
              const SizedBox(height: 10),
              repeatPassword != null
                  ? CommonTextField(
                      hintText: '',
                      controller: repeatPassword!,
                      obsecureText: isObscurePass2)
                  : const SizedBox(),
              const SizedBox(height: 20),
              MainButton(
                onTap: onTap,
                text: title,
              ),
              const SizedBox(
                height: 20,
              ),
              subText
            ]),
      ),
    );
  }
}
