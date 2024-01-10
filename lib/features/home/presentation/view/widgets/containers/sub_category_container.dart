import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/home/data/models/categories_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cachedNetworkImage/my_cached_nework_Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubCategoryContainer extends StatelessWidget {
  const SubCategoryContainer({
    super.key,
    required this.subCategory,
  });

  final SubCategories subCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      width: 170.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),
        color: AppColors.kWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.161),
                    blurRadius: 4.h,
                    offset: Offset(0, 4.h)),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.w),
              child: MyCachedNetworkImage(
                heroId: subCategory.id!,
                height: 120.h,
                width: 240.w,
                url: subCategory.image!,
                errorIcon: Icon(
                  Icons.image,
                  size: 100.w,
                  color: AppColors.kASDCPrimaryColor,
                ),
                loadingWidth: 30.w,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Container(
                width: 45.w,
                height: 20.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.w),
                  color: Colors.green.withOpacity(0.2),
                ),
                child: Center(
                  child: Text(
                    '4.8 #',
                    style: TextStyles.textStyle10,
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Container(
                width: 60.w,
                height: 20.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.w),
                  color: Colors.red.withOpacity(0.2),
                ),
                child: Center(
                  child: Text(
                    'خصم %20',
                    style: TextStyles.textStyle10,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 100.w,
                child: Text(
                  subCategory.categoryName!,
                  style: TextStyles.textStyle14.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 200.w,
            child: Text(
              subCategory.description!,
              style: TextStyles.textStyle10
                  .copyWith(fontWeight: FontWeight.w400, color: Colors.grey),
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
