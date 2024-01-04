import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/constants.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultDialog extends StatelessWidget {
  const ResultDialog({
    super.key,
    required this.title,
    required this.message,
    required this.buttonTitle,
    this.onPressed,
  });

  final String buttonTitle;
  final String message;
  final void Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: kIsTablet ? 50.w : 37.5.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.w),
      ),
      title: Text(
        title,
        style: TextStyles.textStyle20.copyWith(
          color: AppColors.kRed,
        ),
        textAlign: TextAlign.center,
      ),
      contentTextStyle: TextStyles.textStyle16.copyWith(
        color: AppColors.kBlack,
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: (onPressed != null)
          ? [
              AppDefaultButton(
                margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                onPressed: onPressed!,
                title: buttonTitle,
              ),
            ]
          : null,
    );
  }
}
