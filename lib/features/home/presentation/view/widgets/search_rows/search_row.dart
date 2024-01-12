import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SearchRow extends StatelessWidget {
  const SearchRow({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.canGoBack,
    this.whenBack,
    required this.haveFilter,
    this.onFilter,
    required this.onChanged,
  });

  final TextEditingController textEditingController;
  final String hintText;
  final bool canGoBack;
  final void Function()? whenBack;
  final bool haveFilter;
  final void Function()? onFilter;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (haveFilter)
          IconButton(
            onPressed: onFilter,
            icon: SvgPicture.asset('assets/icons/search_Filter.svg'),
          ),
        Expanded(
          child: SizedBox(
            child: TextField(
              controller: textEditingController,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                hintText: hintText,
                hintTextDirection: TextDirection.rtl,
                filled: true,
                fillColor: AppColors.kASDCPrimaryColor.withOpacity(0.09),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.w),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.kASDCPrimaryColor,
                  size: 30.w,
                ),
              ),
              onChanged: onChanged,
            ),
          ),
        ),
        if (canGoBack)
          IconButton(
            onPressed: whenBack,
            icon: Transform.flip(
              flipX: true,
              child: Icon(
                Icons.arrow_back_rounded,
                size: 30.w,
                color: AppColors.kASDCPrimaryColor,
              ),
            ),
          ),
      ],
    );
  }
}
