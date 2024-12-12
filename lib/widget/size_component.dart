import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/size_config.dart';

class SizeComponent extends StatelessWidget {
  double? width,height;
  String? size;
  Color? color,textColor;
  SizeComponent({Key? key,this.width,this.height,this.color,this.size,this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius:const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11.0),
        child: Center(
          child: Text(size!,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: "BahijBold",
            color: textColor,
          ),
          ),
        ),
      ),
    );
  }
}
