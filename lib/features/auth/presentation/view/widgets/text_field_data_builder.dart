import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldDataBulder extends StatelessWidget {
  const TextFieldDataBulder(
      {super.key,
      required this.title,
      required this.onChanged,
      this.validator,
      this.inputFormatters});

  final String title;

  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

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
            child: TextFormField(
              validator: validator,
              onChanged: onChanged,
              inputFormatters: inputFormatters,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              style: TextStyles.textStyle14,
              textDirection: TextDirection.rtl,
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
