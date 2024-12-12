import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../core/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final double minWidth, maxWidth, minHeight, maxHeight;
  final Function(String) onChanged;
  final String hint;
  final TextStyle textStyle,hintStyle;

  CustomTextField({
    Key? key,
    required this.maxWidth,
    required this.minWidth,
    required this.minHeight,
    required this.hint,
    required this.maxHeight,
    required this.onChanged,
    required this.textStyle,
    required this.hintStyle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: minHeight,
            minWidth: minWidth,
            maxWidth: maxWidth,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: AppColors.upperNavBarBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: textStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle:  hintStyle,
                  labelStyle: textStyle,
                  contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  counterText: "",

                ),
                onChanged: onChanged),
          ),
        ),

      ],
    );
  }
}
