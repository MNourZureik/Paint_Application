import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Logo1 extends StatelessWidget {
  final double width,height;
  const Logo1({key, required this.height,required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          Center(
            child: Container(
              child: SvgPicture.asset("assets/images/Logo1.svg"),
            ),
          ),
        ],
      ),
    );
  }
}
