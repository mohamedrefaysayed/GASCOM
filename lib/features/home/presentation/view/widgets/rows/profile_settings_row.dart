import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSettingsRow extends StatelessWidget {
  const ProfileSettingsRow({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          child: Container(
            height: 60.h,
            decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.circular(15.w),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kGrey.withOpacity(0.3),
                    blurRadius: 10.w,
                    spreadRadius: 5.w,
                  )
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 30.w,
                    color: AppColors.kASDCPrimaryColor,
                  ),
                  const Spacer(),
                  Text(
                    title,
                    style: TextStyles.textStyle16,
                  )
                ],
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.w),
          child: Material(
            color: AppColors.kTransparent,
            child: SizedBox(
              height: 80.h,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ),
        )
      ],
    );
  }
}
