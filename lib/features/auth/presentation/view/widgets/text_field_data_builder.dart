import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldDataBulder extends StatelessWidget {
  const TextFieldDataBulder(
      {super.key, required this.title, required this.onChanged});

  final String title;

  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyles.textStyle16.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 50.h,
            child: TextField(
              style: TextStyles.textStyle14,
              textDirection: TextDirection.rtl,
              onChanged: onChanged,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.w),
                      borderSide: const BorderSide(
                          color: AppColors.kASDCPrimaryColor))),
            ),
          ),
        ],
      ),
    );
  }
}
