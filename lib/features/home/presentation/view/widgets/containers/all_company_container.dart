import 'package:dinar_store/core/functions/future_delayed_navigator.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/home/data/models/companies_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cachedNetworkImage/my_cached_nework_Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllCompanyContainer extends StatelessWidget {
  const AllCompanyContainer({
    super.key,
    required this.company,
  });

  final Companies company;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 75.w,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(15.w),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.161),
                  blurRadius: 6.w,
                  offset: Offset(0, 3.h)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyCachedNetworkImage(
                height: 35.w,
                width: 35.w,
                url: company.logo!,
                errorIcon: Icon(
                  Icons.home_work_rounded,
                  size: 30.w,
                  color: AppColors.kASDCPrimaryColor,
                ),
                loadingWidth: 13.w,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                company.companyName!,
                style: TextStyles.textStyle10
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        Material(
          color: AppColors.kTransparent,
          child: InkWell(
            onTap: () {
              futureDelayedNavigator(() {});
            },
            borderRadius: BorderRadius.circular(15.w),
            child: SizedBox(
              height: 75.w,
              width: 75.w,
            ),
          ),
        ),
      ],
    );
  }
}
