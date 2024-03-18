// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/core/widgets/app_loading_button.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/home/data/models/sub_category_products_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cachedNetworkImage/my_cached_nework_Image.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/required_products_show.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/rows/product_amount_row.dart';
import 'package:dinar_store/features/home/presentation/view_model/cart_cubit/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductView extends StatefulWidget {
  const ProductView({
    super.key,
    required this.product,
  });

  final Products product;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  ValueNotifier<int> retailCount = ValueNotifier<int>(0);
  ValueNotifier<int> wholeCount = ValueNotifier<int>(0);
  ValueNotifier<double> totalRetailPrice = ValueNotifier<double>(0);
  ValueNotifier<double> totalWholePrice = ValueNotifier<double>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: 300.h,
              ),
              child: Hero(
                tag: 'Product${widget.product.id}',
                child: MyCachedNetworkImage(
                  fit: BoxFit.contain,
                  url: widget.product.image!,
                  errorIcon: Icon(
                    Icons.image,
                    size: 150.w,
                    color: AppColors.kASDCPrimaryColor,
                  ),
                  loadingWidth: 13.w,
                ),
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
                      widget.product.productName!,
                      style: TextStyles.textStyle16.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.w,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      widget.product.description!,
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
                            text: "\$${widget.product.retailPrice}, ",
                            style: TextStyles.textStyle10.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                          TextSpan(
                            text: "\$${widget.product.wholeSalePrice}",
                            style: TextStyles.textStyle16.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.green,
                              fontSize: 16.w,
                            ),
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
                    style: TextStyles.textStyle16.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.w,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ProductAmountRow(
                  retailPrice: widget.product.retailPrice!,
                  wholeSalePrice: widget.product.wholeSalePrice!,
                  title: 'برتقال , جزر',
                  retailCount: retailCount,
                  wholeCount: wholeCount,
                  totalRetailPrice: totalRetailPrice,
                  totalWholePrice: totalWholePrice,
                  minRetail:
                      double.parse(widget.product.minRetailQuantity!).toInt(),
                  maxRetail:
                      double.parse(widget.product.maxRetailQuantity!).toInt(),
                  minWhole:
                      double.parse(widget.product.minWholeQuantity!).toInt(),
                  maxWhole:
                      double.parse(widget.product.maxWholeQuantity!).toInt(),
                  itemImage: widget.product.image!,
                ),
                // SizedBox(
                //   height: 20.h,
                // ),
                // const ProductAmountRow(
                //   retailPrice: '14.25',
                //   wholeSalePrice: '13.90',
                //   title: 'برتقال',
                // ),
                // SizedBox(
                //   height: 20.h,
                // ),
                // const ProductAmountRow(
                //   retailPrice: '14.25',
                //   wholeSalePrice: '13.90',
                //   title: 'جزر',
                // ),
                // SizedBox(
                //   height: 20.h,
                // ),
                // const ProductAmountRow(
                //   retailPrice: '14.25',
                //   wholeSalePrice: '13.90',
                //   title: 'كوسة',
                // ),
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
                      ValueListenableBuilder(
                        valueListenable: wholeCount,
                        builder:
                            (BuildContext context, int value, Widget? child) {
                          return Text(
                            value.toString(),
                            style: TextStyles.textStyle14.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.kASDCPrimaryColor),
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                          );
                        },
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
                      ValueListenableBuilder(
                        valueListenable: retailCount,
                        builder:
                            (BuildContext context, int value, Widget? child) {
                          return Text(
                            value.toString(),
                            style: TextStyles.textStyle14.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.kASDCPrimaryColor),
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                          );
                        },
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
                      ValueListenableBuilder(
                        valueListenable: totalWholePrice,
                        builder: (BuildContext context, double value,
                            Widget? child) {
                          return Text(
                            "\$$value",
                            style: TextStyles.textStyle14.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.kASDCPrimaryColor),
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                          );
                        },
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
                      ValueListenableBuilder(
                        valueListenable: totalRetailPrice,
                        builder: (BuildContext context, double value,
                            Widget? child) {
                          return Text(
                            "\$$value",
                            style: TextStyles.textStyle14.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.kASDCPrimaryColor),
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                          );
                        },
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
                        child: BlocConsumer<CartCubit, CartState>(
                          listener: (context, state) {
                            if (state is AddToCartSuccess) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  messageSnackBar(
                                      message: "تمت الإضافة الى العربة"));
                            }
                          },
                          builder: (context, state) {
                            if (state is AddToCartLoading) {
                              return const AppLoadingButton();
                            }
                            return AppDefaultButton(
                              color: AppColors.kASDCPrimaryColor,
                              icon: Icon(
                                Icons.shopping_cart_rounded,
                                color: Colors.white,
                                size: 20.w,
                              ),
                              onPressed: () async {
                                if ((totalRetailPrice.value +
                                        totalWholePrice.value) >
                                    0) {
                                  if (widget.product.requiredProducts != null &&
                                      widget.product.requiredProducts!
                                          .isNotEmpty) {
                                    await showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return RequiredProductsShow(
                                          product: widget.product,
                                          retailCount: retailCount,
                                          totalRetailPrice: totalRetailPrice,
                                        );
                                      },
                                    );
                                  } else {
                                    await context.read<CartCubit>().storeItem(
                                      productId: widget.product.id!,
                                      quantity: retailCount.value,
                                      unitId: int.parse(
                                          widget.product.retailUnitId!),
                                      price: totalRetailPrice.value,
                                      isRequired: '0',
                                      isLast: true,
                                      requiredProducts: [],
                                    );
                                  }
                                  context.read<CartCubit>().getAllItems();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      messageSnackBar(message: "أختر الكمية"));
                                }
                              },
                              title: 'إضافة',
                              textStyle: TextStyles.textStyle12.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.w,
                              ),
                            );
                          },
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
                              child: ValueListenableBuilder(
                                valueListenable: totalRetailPrice,
                                builder: (BuildContext context,
                                    double totalRetailPricevalue,
                                    Widget? child) {
                                  return ValueListenableBuilder(
                                    valueListenable: totalWholePrice,
                                    builder: (BuildContext context,
                                        double totalwholePricevalue,
                                        Widget? child) {
                                      return Text(
                                        '\$${totalRetailPricevalue + totalwholePricevalue} : المجموع',
                                        style: TextStyles.textStyle14.copyWith(
                                          fontSize: 14.w,
                                          color: AppColors.kASDCPrimaryColor,
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    },
                                  );
                                },
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
    );
  }
}
