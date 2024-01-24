import 'package:dinar_store/core/animations/right_slide_transition.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/rows/profile_settings_row.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: ListView(
          shrinkWrap: true,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: AppDefaultButton(
                width: 150.w,
                color: AppColors.kASDCPrimaryColor,
                onPressed: () {
                  Navigator.push(
                      context, RightSlideTransition(page: const SettingView()));
                },
                icon: Icon(
                  Icons.settings,
                  size: 25.w,
                  color: Colors.white,
                ),
                title: ' الاعدادات',
                textStyle: TextStyles.textStyle14.copyWith(
                  color: AppColors.kWhite,
                ),
              ),
            ),
            const GeneralDivider(),
            ProfileSettingsRow(
              title: 'معلومات عن التطبيق',
              onTap: () {},
            ),
            const GeneralDivider(),
            ProfileSettingsRow(
              title: 'معلومات عن المطوريين',
              onTap: () {},
            ),
            const GeneralDivider(),
            ProfileSettingsRow(
              title: 'الدعم',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
