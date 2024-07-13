import 'package:dinar_store/core/functions/show_alert_dialog.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_loading_button.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/auth/presentation/view_model/log_out_cubit/log_out_cubit.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/rows/profile_settings_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogOutContainer extends StatelessWidget {
  const LogOutContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogOutCubit, LogOutState>(
      listener: (context, state) {
        if (state is LogOutFailure) {
          context.showMessageSnackBar(message: state.errMessage);
        }
      },
      builder: (context, state) {
        if (state is LogOutLoading) {
          return SizedBox(
            width: 250.w,
            child: AppLoadingButton(
              width: 10.w,
            ),
          );
        }
        return ProfileSettingsRow(
          title: 'تسجيل الخروج',
          onTap: () {
            showAlertDialog(context,
                child: AlertDialog(
                  title: Center(
                    child: Text(
                      'هل تريد تسجيل الخروج؟',
                      style: TextStyles.textStyle18,
                    ),
                  ),
                  actions: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'إلغاء',
                            style: TextStyles.textStyle14.copyWith(
                              color: AppColors.kASDCPrimaryColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            context.read<LogOutCubit>().logOut();
                            Navigator.pop(context);
                          },
                          child: Text(
                            'خروج',
                            style: TextStyles.textStyle14.copyWith(
                              color: AppColors.kASDCPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ));
          },
          icon: Icons.logout_outlined,
        );
      },
    );
  }
}
