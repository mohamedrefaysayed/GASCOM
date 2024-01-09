import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CompaniesPlaceHolder extends StatelessWidget {
  const CompaniesPlaceHolder({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.3),
      highlightColor: AppColors.kASDCPrimaryColor.withOpacity(0.5),
      child: SizedBox(
        height: 200.h,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'الشركـــــــــــات',
                  style: TextStyles.textStyle16
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Wrap(
              alignment: WrapAlignment.end,
              runAlignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: 10.w,
              runSpacing: height / 3.3 / 20,
              children: List.generate(
                8,
                (index) {
                  return Container(
                    height: 75.w,
                    width: 75.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.w),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.161),
                            blurRadius: 6.w,
                            offset: Offset(0, 3.h)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
