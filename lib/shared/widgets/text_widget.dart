import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget {
  static Widget lightText({
    String? text,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    double? letterSpacing = .15,
    int? maxLines = 1,
  }) {
    return AutoSizeText(
      text!,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      style: GoogleFonts.ebGaramond(
        textStyle: TextStyle(
          letterSpacing: letterSpacing,
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w300, // Use FontWeight.w300 for Light
        ),
      ),
    );
  }

  static Widget boldText(
      {String? text,
      Color? color,
      double? fontSize,
      TextAlign? textAlign,
      int? maxLines = 1,
      double? height,
      double? letterSpacing = .15,
      TextOverflow? overflow}) {
    return AutoSizeText(
      text!,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      style: GoogleFonts.ebGaramond(
        textStyle: TextStyle(
          height: height, overflow: overflow,
          letterSpacing: letterSpacing,
          color: color,

          fontSize: fontSize,
          fontWeight: FontWeight.bold, // Use FontWeight.bold for Bold
        ),
      ),
    );
  }

  static Widget mediumText({
    String? text,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    double? minFontSize = 12,
    int? maxLines = 1,
    double? lineHeight,
    double? letterSpacing = .15,
  }) {
    return AutoSizeText(
      text!,
      textAlign: textAlign ?? TextAlign.start,
      minFontSize: minFontSize!,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: GoogleFonts.ebGaramond(
        textStyle: TextStyle(
          height: lineHeight,
          letterSpacing: letterSpacing,
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500, // Use FontWeight.bold for Bold
        ),
      ),
    );
  }

  static Widget extraBoldText({
    String? text,
    Color? color,
    double? fontSize,
    int? maxLines = 1,
    TextAlign? textAlign,
    double? letterSpacing = .15,
  }) {
    return AutoSizeText(
      text!,
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      style: GoogleFonts.ebGaramond(
        textStyle: TextStyle(
          letterSpacing: letterSpacing,
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w800, // Use FontWeight.w800 for Extra Bold
        ),
      ),
    );
  }

  static Widget regularText({
    String? text,
    Color? color,
    double? fontSize,
    int? maxLines = 1,
    TextAlign? textAlign,
    double? letterSpacing = .15,
  }) {
    return AutoSizeText(
      text!,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      minFontSize: 8,
      style: GoogleFonts.ebGaramond(
        textStyle: TextStyle(
          letterSpacing: letterSpacing,
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.normal, // Use FontWeight.normal for Regular
        ),
      ),
    );
  }

  static Widget semiBoldText({
    String? text,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    double? letterSpacing = .15,
    int? maxLines = 2,
    double? height,
  }) {
    return AutoSizeText(
      text!,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.ebGaramond(
        textStyle: TextStyle(
          letterSpacing: letterSpacing,
          color: color,
          fontSize: fontSize, height: height,
          fontWeight: FontWeight.w600, // Use FontWeight.w600 for Semi-Bold
        ),
      ),
    );
  }

  static Widget outLineText({
    String? text,
    Color? color,
    int? maxLines = 1,
    double? fontSize,
    TextAlign? textAlign,
    double? letterSpace,
  }) {
    return AutoSizeText(
      text!,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      style: GoogleFonts.getFont(
        'YourOutLineFont', // Replace 'YourOutLineFont' with the actual outline font name
        textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          letterSpacing: letterSpace ?? 8,
        ),
      ),
    );
  }

  static TextStyle customTextStyle({
    Color? color,
    FontWeight? weight,
    double? fontSize,
    TextAlign? textAlign,
    double? letterSpacing = .15,
    int? maxLines = 2,
    double? height,
  }) {
    return GoogleFonts.ebGaramond(
      textStyle: TextStyle(
        letterSpacing: letterSpacing,
        color: color,

        fontSize: fontSize, height: height,
        fontWeight: weight, // Use FontWeight.w600 for Semi-Bold
      ),
    );
  }

  static errorText({errorMessage}) {
    return regularText(text: errorMessage, color: Colors.red, fontSize: 10);
  }
}
