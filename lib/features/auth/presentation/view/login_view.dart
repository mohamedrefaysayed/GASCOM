// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, use_build_context_synchronously

import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/app_images.dart';
import 'package:dinar_store/features/auth/presentation/view/widgets/code_builder.dart';
import 'package:dinar_store/features/auth/presentation/view/widgets/phone_builder.dart';
import 'package:dinar_store/features/auth/presentation/view_model/log_in_cubit/log_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  static const String id = '/LogInView';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: ListView(
          children: [
            BlocBuilder<LogInCubit, LogInState>(
              builder: (context, state) {
                if (state is SendCodeSuccess || state is SendPhoneLoading) {
                  return Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context.read<LogInCubit>().emit(LogInInitial());
                            LogInCubit.phoneNumber = null;
                          },
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            size: 25.w,
                          ))
                    ],
                  );
                }
                return SizedBox(
                  height: 45.h,
                );
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            Center(
              child: Image.asset(
                AppImages.loginCart,
                height: 177.w,
                width: 177.w,
              ),
            ),
            SizedBox(
              height: 20.h,
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
              height: 70.h,
            ),
            BlocBuilder<LogInCubit, LogInState>(
              builder: (context, state) {
                if (state is SendCodeSuccess || state is SendPhoneLoading) {
                  return const CodeBuilder();
                } else {
                  return const PhoneBuilder();
                }
              },
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      )),
    );
  }
}
