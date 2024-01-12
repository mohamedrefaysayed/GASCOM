import 'package:dinar_store/core/functions/future_delayed_navigator.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDefaultButton extends StatelessWidget {
  const AppDefaultButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
    this.margin,
    this.showBorder = false,
    this.textStyle,
    this.width,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.icon,
  });

  final void Function() onPressed;
  final String title;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final bool showBorder;
  final TextStyle? textStyle;
  final double? width;
  final Color? color;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.h,
      width: width ?? 300.w,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(15.w),
        border: showBorder
            ? Border.all(
                color: borderColor ?? Colors.black,
                width: 1.w,
              )
            : null,
        color: color ?? Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius ?? BorderRadius.circular(15.w),
          onTap: () {
            futureDelayedNavigator(() {
              onPressed();
            });
          },
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) icon!,
                Text(
                  title,
                  style: textStyle ??
                      (TextStyles.textStyle14.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
