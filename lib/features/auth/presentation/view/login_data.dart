import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/app_images.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/features/auth/presentation/view/widgets/text_field_data_builder.dart';
import 'package:dinar_store/features/auth/presentation/view_model/log_in_cubit/log_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginData extends StatelessWidget {
  const LoginData({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          LogInCubit.phoneNumber = null;
          LogInCubit.code = null;
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: ListView(
            children: [
              SizedBox(
                height: 70.h,
              ),
              Hero(
                tag: 'dinar_logo',
                child: Center(
                  child: Image.asset(
                    AppImages.dinarLogo,
                    height: 40.w,
                    width: 177.w,
                    color: AppColors.kASDCPrimaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              TextFieldDataBulder(
                title: 'الاسم الثلاثي لصاحب العمل',
                onChanged: (value) {},
              ),
              TextFieldDataBulder(
                title: 'أسم الماركت ',
                onChanged: (value) {},
              ),
              TextFieldDataBulder(
                title: 'المحافظة',
                onChanged: (value) {},
              ),
              TextFieldDataBulder(
                title: 'العنوان الكامل مع اقرب نقطة دالة',
                onChanged: (value) {},
              ),
              TextFieldDataBulder(
                title: 'رقم هاتف الماركت(العمل)',
                onChanged: (value) {},
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                child: AppDefaultButton(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 25.w,
                  ),
                  textStyle: TextStyles.textStyle16.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                  onPressed: () {},
                  title: 'تحديد موقعي',
                  color: AppColors.kASDCPrimaryColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: AppDefaultButton(
                  textStyle: TextStyles.textStyle16.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                  onPressed: () {},
                  title: 'حفظ',
                  color: AppColors.kASDCPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
