import 'package:dinar_store/core/functions/future_delayed_navigator.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/home/data/models/sub_category_products_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cachedNetworkImage/my_cached_nework_Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubCategoryProductContainer extends StatelessWidget {
  const SubCategoryProductContainer({
    super.key,
    required this.product,
  });

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            color: AppColors.kWhite,
          ),
          child: Row(
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
                child: Hero(
                  tag: "Product${product.id}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.w),
                    child: MyCachedNetworkImage(
                      height: 70.h,
                      width: 90.w,
                      url: product.image!,
                      errorIcon: Icon(
                        Icons.image,
                        size: 50.w,
                        color: AppColors.kASDCPrimaryColor,
                      ),
                      loadingWidth: 30.w,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      product.productName!,
                      style: TextStyles.textStyle12
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      product.description!,
                      style: TextStyles.textStyle10.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Text(
                          product.retailPrice!,
                          style: TextStyles.textStyle12.copyWith(
                              fontWeight: FontWeight.w400, color: Colors.grey),
                        ),
                        Text(
                          product.vipPrice!,
                          style: TextStyles.textStyle12.copyWith(
                              fontWeight: FontWeight.w400, color: Colors.green),
                        ),
                      ],
                    )
                  ],
                ),
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
              height: 60.w,
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }
}
