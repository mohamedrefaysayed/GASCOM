import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AdsPlaceHolder extends StatelessWidget {
  const AdsPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.3),
        highlightColor: AppColors.kASDCPrimaryColor.withOpacity(0.5),
        child: Container(
          height: 185.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.161),
                blurRadius: 6.w,
                offset: Offset(0, 3.h),
              ),
            ],
            borderRadius: BorderRadius.circular(15.w),
          ),
        ),
      ),
    );
  }
}
