import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SearchRow extends StatelessWidget {
  const SearchRow(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.onPerssedFilter,
      required this.canGoBack,
      this.whenBack,
      required this.haveFilter,
      this.onFilter});

  final TextEditingController textEditingController;
  final String hintText;
  final void Function() onPerssedFilter;
  final bool canGoBack;
  final void Function()? whenBack;
  final bool haveFilter;
  final void Function()? onFilter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (haveFilter)
          IconButton(
            onPressed: onPerssedFilter,
            icon: SvgPicture.asset('assets/icons/search_Filter.svg'),
          ),
        Expanded(
          child: SizedBox(
            height: 50.h,
            child: TextField(
              controller: textEditingController,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
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
                    size: 35.w,
                  )),
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
