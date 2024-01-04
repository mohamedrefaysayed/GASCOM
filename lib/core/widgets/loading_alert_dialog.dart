import 'package:dinar_store/core/utils/constants.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingAlertDialog extends StatelessWidget {
  const LoadingAlertDialog({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.w),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 35.h,
            width: kIsTablet ? 27.5.w : 35.w,
            child: CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: kIsTablet ? 2.5.w : 3.5.w,
            ),
          ),
          SizedBox(width: 20.w),
          Text(
            text,
            style: TextStyles.textStyle14,
          ),
        ],
      ),
    );
  }
}
