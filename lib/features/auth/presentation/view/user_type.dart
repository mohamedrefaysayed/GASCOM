import 'package:dinar_store/core/animations/right_slide_transition.dart';
import 'package:dinar_store/core/helpers/app_cache/cahch_helper.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/genrall.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/features/auth/presentation/view/login_view.dart';
import 'package:dinar_store/features/auth/presentation/view/login_view_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserType extends StatelessWidget {
  const UserType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'أختر وظيفتك',
              style: TextStyles.textStyle20.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20.w,
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            AppDefaultButton(
              color: AppColors.kASDCPrimaryColor,
              onPressed: () {
                isCustomer = true;
                CahchHelper.saveData(key: "isCustomer", value: true);
                Navigator.push(
                    context, RightSlideTransition(page: const LogInView()));
              },
              title: 'مستخدم',
              textStyle: TextStyles.textStyle16.copyWith(
                fontSize: 16.w,
                fontWeight: FontWeight.w700,
                color: AppColors.kWhite,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            AppDefaultButton(
              color: AppColors.kASDCPrimaryColor,
              onPressed: () {
                isCustomer = false;
                CahchHelper.saveData(key: "isCustomer", value: false);
                Navigator.push(context,
                    RightSlideTransition(page: const LogInViewAgent()));
              },
              title: 'وكيل',
              textStyle: TextStyles.textStyle16.copyWith(
                fontSize: 16.w,
                fontWeight: FontWeight.w700,
                color: AppColors.kWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
