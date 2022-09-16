import 'package:flutter/material.dart';
import 'package:todo/common/pallete.dart';


class button extends StatelessWidget {
  void Function()? onPressed;
  Widget? child;
  Color? color;
  double? elevation;
  double? minWidth;
  ShapeBorder? shape;
  String? text;
  EdgeInsetsGeometry? padding;
  double? fontSize;
  button({Key? key, this.onPressed, this.child, this.color, this.elevation, this.minWidth, this.shape, this.text, this.padding, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        elevation: elevation ?? 0,
        color: color ?? Palette.themePallete,
        onPressed: onPressed ?? (){},
        minWidth: minWidth,
        shape: shape ?? RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60)
        ),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: child ?? Text(
          text ?? 'BUTTON',
          style: TextStyle(
          color: Colors.white,
          fontSize: fontSize ?? 16,
          fontWeight: FontWeight.w700
        ),),
    );
  }
}
