// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/features/home/data/models/sub_category_products_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cachedNetworkImage/my_cached_nework_Image.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/rows/product_amount_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    super.key,
    required this.product,
  });

  final Products product;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Hero(
                tag: 'Product${product.id}',
                child: MyCachedNetworkImage(
                  fit: BoxFit.contain,
                  url: product.image!,
                  errorIcon: Icon(
                    Icons.image,
                    size: 150.w,
                    color: AppColors.kASDCPrimaryColor,
                  ),
                  loadingWidth: 13.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        product.productName!,
                        style: TextStyles.textStyle16
                            .copyWith(fontWeight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        product.description!,
                        style: TextStyles.textStyle10.copyWith(
                            fontWeight: FontWeight.w400, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: "\$${product.retailPrice}, ",
                              style: TextStyles.textStyle10.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            TextSpan(
                              text: "\$${product.vipPrice}",
                              style: TextStyles.textStyle16.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.green),
                            ),
                          ]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const GeneralDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Text(
                      'النكهات',
                      style: TextStyles.textStyle16
                          .copyWith(fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const ProductAmountRow(
                    retailPrice: '14.25',
                    wholeSalePrice: '13.90',
                    title: 'برتقال , جزر',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const ProductAmountRow(
                    retailPrice: '14.25',
                    wholeSalePrice: '13.90',
                    title: 'برتقال',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const ProductAmountRow(
                    retailPrice: '14.25',
                    wholeSalePrice: '13.90',
                    title: 'جزر',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const ProductAmountRow(
                    retailPrice: '14.25',
                    wholeSalePrice: '13.90',
                    title: 'كوسة',
                  ),
                ],
              ),
              const GeneralDivider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        AppDefaultButton(
                            height: 30.h,
                            width: 90.w,
                            color: AppColors.kASDCPrimaryColor,
                            onPressed: () {},
                            textStyle: TextStyles.textStyle10.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                            title: 'فرض مع المنتج'),
                        const Spacer(),
                        Text(
                          'ملاحظات أخرى',
                          style: TextStyles.textStyle14
                              .copyWith(fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      minLines: 4,
                      maxLines: null,
                      textDirection: TextDirection.rtl,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          hintText: 'اكتب ملاحظاتك',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.w),
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.05),
                              ))),
                    ),
                  ],
                ),
              ),
              const GeneralDivider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          '89',
                          style: TextStyles.textStyle14.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.kASDCPrimaryColor),
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                        const Spacer(),
                        Text(
                          'الاعداد بالجملة',
                          style: TextStyles.textStyle14
                              .copyWith(fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          '64',
                          style: TextStyles.textStyle14.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.kASDCPrimaryColor),
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                        const Spacer(),
                        Text(
                          'الاعداد بالمفرد',
                          style: TextStyles.textStyle14
                              .copyWith(fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          '\$89.29',
                          style: TextStyles.textStyle14.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.kASDCPrimaryColor),
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                        const Spacer(),
                        Text(
                          'السعر بالجملة',
                          style: TextStyles.textStyle14
                              .copyWith(fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          '\$23.23',
                          style: TextStyles.textStyle14.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.kASDCPrimaryColor),
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                        const Spacer(),
                        Text(
                          'السعر بالمفرد',
                          style: TextStyles.textStyle14
                              .copyWith(fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: AppDefaultButton(
                            color: AppColors.kASDCPrimaryColor,
                            icon: Icon(
                              Icons.shopping_cart_rounded,
                              color: Colors.white,
                              size: 20.w,
                            ),
                            onPressed: () {},
                            title: 'إضافة إلى عربة التسوق',
                            textStyle: TextStyles.textStyle12.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.w),
                              ),
                              child: Center(
                                child: Text(
                                  '\$89.29 : السعرالكلي',
                                  style: TextStyles.textStyle14.copyWith(
                                      color: AppColors.kASDCPrimaryColor,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
