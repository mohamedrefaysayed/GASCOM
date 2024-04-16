// ignore_for_file: file_names

import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DevoloperData extends StatelessWidget {
  const DevoloperData({super.key});

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
                    child: Image.asset('assets/images/MOHAMED_REFAY.jpg')),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Moahmed Refay',
              style: TextStyles.textStyle28.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.h),
            Wrap(
              children: [
                Text(
                  '''Experienced Flutter developer adept in Mobile App front-end development, UI design, and Firebase project creation. Proficient in implementing state management for robust app architecture and seamlessly integrating web service APIs. Known for adaptability to new technologies and meticulous attention to detail, consistently delivering creative solutions. Eager to leverage versatile skill set to drive impactful contributions in mobile app development teams.''',
                  style: TextStyles.textStyle16.copyWith(),
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
            SizedBox(
              height: 100.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // faceBook
                GestureDetector(
                  onTap: () {
                    launchUrlString(
                      "https://www.facebook.com/mohamed.refay.773",
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: SvgPicture.asset(
                    "assets/icons/facebook.svg",
                    height: 40.w,
                    width: 40.w,
                    colorFilter: const ColorFilter.mode(
                        AppColors.kASDCPrimaryColor, BlendMode.srcATop),
                  ),
                ),

                // LinkedIn
                GestureDetector(
                  onTap: () {
                    launchUrlString(
                      "https://www.linkedin.com/in/mohamed-refay-8286941b8/",
                      mode: LaunchMode.externalNonBrowserApplication,
                    );
                  },
                  child: SvgPicture.asset(
                    "assets/icons/linkedin.svg",
                    height: 40.w,
                    width: 40.w,
                    colorFilter: const ColorFilter.mode(
                      AppColors.kASDCPrimaryColor,
                      BlendMode.srcATop,
                    ),
                  ),
                ),

                // Wahtsapp
                GestureDetector(
                  onTap: () {
                    launchUrlString(
                      "whatsapp://send?phone=+201090287571",
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: SvgPicture.asset(
                    "assets/icons/whatsapp.svg",
                    height: 40.w,
                    width: 40.w,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
