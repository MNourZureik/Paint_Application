import 'package:flutter/material.dart';
import '/core/app_colors.dart';

class CustomButton extends StatelessWidget {
  String? text;
  double? width,height;
  TextStyle? textStyle;
  Color? backgroundColor;
  bool? hasBorder;
  Function()? onTap;
  CustomButton({Key? key,this.width,this.height,this.textStyle,this.backgroundColor,this.hasBorder=false,this.text,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color:backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          border: hasBorder!? Border.all(color: AppColors.greenTextColor,width: .75):Border.all(color: Colors.transparent,width: 0),
        ),
        child: Center(
          child: Text(text!,
          style: textStyle,
          ),
        ),
      ),
    );
  }
}
