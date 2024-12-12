import 'package:flutter/material.dart';
import '/core/app_colors.dart';

class CustomInputField extends StatelessWidget {
  final double width, height;
  final Function(String) onChanged;
  final IconData? icon;
  final bool error,isPassword;
  final String errorText, hintText;
  final TextStyle? hintStyle,textStyle;
  final TextInputType textInputType;
  final bool? isGrey;
  final int? maxLength;

  const CustomInputField(
      {required this.width,
      required this.height,
      required this.onChanged,
      this.icon,
      this.error = false,
      this.errorText = "",
      this.hintText = "",
      this.hintStyle,
      this.textInputType = TextInputType.text,
      this.maxLength,
        this.textStyle,
        this.isGrey=false,
      this.isPassword=false})
      : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(36)),
        color: !isGrey!?AppColors.white:AppColors.upperNavBarBackgroundColor,

      ),
      width: width,
      height: height,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0,0.0,10.0,0.0),
          child: TextField(
            keyboardType: textInputType,
            onChanged: onChanged,
            obscureText: isPassword,
            cursorColor: const Color(0xff6800FF),
            style: textStyle,
            decoration: InputDecoration(
                errorText: error ? errorText : null,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle:  hintStyle,
                labelStyle: textStyle,
                contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              counterText: "",

            ),
            maxLength: maxLength,



          ),
        ),
      ),
    );
  }
}
