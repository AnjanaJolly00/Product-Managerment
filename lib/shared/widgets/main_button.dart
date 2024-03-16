import 'package:flutter/material.dart';
import 'package:machinetest/shared/utils/app_colors.dart';
import 'text_widget.dart';

class MainButton extends StatelessWidget {
  final void Function()? onTap;
  final String? text;
  final double? height;
  final double? width;

  final double borderRadius;
  final Widget? suffixIcon;
  final Color? bgColor;
  final Color? borderColor;
  final Widget? textWidget;

  const MainButton(
      {this.onTap,
      this.text,
      this.width,
      this.borderRadius = 6,
      this.bgColor = AppColors.themeColor,
      this.textWidget,
      this.height = 50,
      this.borderColor = AppColors.themeColor,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            backgroundColor: bgColor,
            side: BorderSide(
                color: borderColor ?? AppColors.themeColor,
                width: 1,
                style: BorderStyle.solid),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget ??
                    TextWidget.boldText(
                        color: AppColors.white, fontSize: 15, text: text),
                const SizedBox(
                  width: 3,
                ),
                suffixIcon ?? const SizedBox()
              ],
            ),
          )

          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
    );
  }
}
