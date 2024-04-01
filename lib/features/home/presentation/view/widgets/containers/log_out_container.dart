import 'package:dinar_store/core/functions/show_alert_dialog.dart';
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
          ScaffoldMessenger.of(context)
              .showSnackBar(messageSnackBar(message: state.errMessage));
        }
        if (state is LogOutSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, 'usertype', (route) => false);
          ScaffoldMessenger.of(context)
              .showSnackBar(messageSnackBar(message: "تم الخروج بنجاح"));
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
                  title: const Text('هل تريد تسجيل الخروج؟'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('إلغاء'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<LogOutCubit>().logOut();
                        Navigator.pop(context);
                      },
                      child: const Text('خروج'),
                    ),
                  ],
                ));
          },
          icon: Icons.logout_outlined,
        );
      },
    );
  }
}
