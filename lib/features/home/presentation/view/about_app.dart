// ignore_for_file: file_names

import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 50.h,
        ),
        child: Column(
          children: [
            Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.kASDCPrimaryColor,
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: ClipOval(
                    child: Image.asset('assets/images/gascomLogo.png')),
              ),
            ),
            SizedBox(height: 50.h),
            Text(
              'Gaznaa',
              style: TextStyles.textStyle28.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 100.h),
            Wrap(
              children: [
                Text(
                  '''تطبيق غازنا الوسيط بين المستخدم ووكيل الغاز حيث يسهل عليك شراء وتوصيل الغاز الى البيت بدون عناء وبطريقة سهلة وضمان الجودة للطرفين''',
                  style: TextStyles.textStyle16.copyWith(),
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
