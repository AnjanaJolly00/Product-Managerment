import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:machinetest/shared/utils/app_colors.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obsecureText;
  final TextInputType? textInputType;
  final TextAlign? textAlign;
  final Function(String)? onChanged;
  final bool? readOnly;
  final int? maxLines;
  final Color bgColor;
  final int? maxlength;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool hasError;
  final String? errorText;
  Widget? label;
  EdgeInsetsGeometry? contentPadding;
  FocusNode? focusNode;
  List<TextInputFormatter>? inputFormatters;
  Key? key;

  CommonTextField(
      {required this.hintText,
      required this.controller,
      this.suffixIcon,
      this.validator,
      this.key,
      this.obsecureText,
      this.prefixIcon,
      this.textInputType,
      this.onChanged,
      this.focusNode,
      this.hasError = false,
      this.errorText,
      this.readOnly = false,
      this.maxLines = 1,
      this.bgColor = const Color.fromRGBO(255, 255, 255, 0.2),
      this.hintStyle,
      this.maxlength,
      this.contentPadding,
      this.inputFormatters,
      this.borderColor = AppColors.white,
      this.labelStyle,
      this.label,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      padding: const EdgeInsets.only(left: 10, right: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 0.304,
          color:
              hasError ? Colors.red : const Color.fromARGB(255, 191, 193, 180)!,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          prefixIcon ?? const SizedBox(),
          Expanded(
            child: TextField(
              inputFormatters: inputFormatters ?? [],
              readOnly: readOnly!, focusNode: focusNode,
              scrollPadding: EdgeInsets.zero,
              maxLines: maxLines!,
              onChanged: onChanged,
              controller: controller,
              cursorColor: Colors.black,
              // validator: validator,
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 14,
                fontWeight:
                    FontWeight.w400, // Use FontWeight.normal for Regular
              ),
              textAlign: textAlign ?? TextAlign.justify,
              keyboardType: textInputType ?? TextInputType.text,
              obscureText: obsecureText ?? false,
              decoration: InputDecoration(
                contentPadding: contentPadding,
                labelStyle: const TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                label: label ?? const SizedBox(),
                // contentPadding: const EdgeInsets.only(
                //   // left: 50,
                //   top: 20,
                // ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 1)),

                fillColor: Colors.transparent,
                filled: true,
                isDense: true,
                hintText: hintText ?? "",
                hintStyle: hintStyle ??
                    const TextStyle(
                      color: AppColors.textColorLight,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
              ),
            ),
          ),
          suffixIcon ?? const SizedBox()
        ],
      ),
    );
  }
}
