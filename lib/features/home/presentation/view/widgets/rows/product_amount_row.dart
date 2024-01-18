import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cachedNetworkImage/my_cached_nework_Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductAmountRow extends StatefulWidget {
  const ProductAmountRow({
    super.key,
    required this.retailPrice,
    required this.wholeSalePrice,
    required this.title,
    required this.retailCount,
    required this.wholeCount,
    required this.totalRetailPrice,
    required this.totalWholePrice,
    required this.minRetail,
    required this.maxRetail,
    required this.minWhole,
    required this.maxWhole,
    required this.itemImage,
  });

  final String retailPrice;
  final String wholeSalePrice;
  final String title;
  final ValueNotifier<int> retailCount;
  final ValueNotifier<int> wholeCount;
  final ValueNotifier<double> totalRetailPrice;
  final ValueNotifier<double> totalWholePrice;
  final int minRetail;
  final int maxRetail;
  final int minWhole;
  final int maxWhole;
  final String itemImage;

  @override
  State<ProductAmountRow> createState() => _ProductAmountRowState();
}

class _ProductAmountRowState extends State<ProductAmountRow> {
  bool value = false;
  ValueNotifier<int> wholeSaleCounter = ValueNotifier<int>(0);
  ValueNotifier<int> retailCounter = ValueNotifier<int>(0);

  @override
  void initState() {
    wholeSaleCounter.value = widget.minWhole;
    retailCounter.value = widget.minRetail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //       width: 5.w,
              //     ),
              //     SizedBox(
              //       width: 60.w,
              //       child: Text(
              //         widget.title,
              //         style:
              //             TextStyles.textStyle12.copyWith(color: Colors.grey),
              //         textDirection: TextDirection.rtl,
              //         overflow: TextOverflow.ellipsis,
              //       ),
              //     ),
              //     Checkbox(
              //         activeColor: AppColors.kASDCPrimaryColor,
              //         value: value,
              //         onChanged: (v) {
              //           value = v!;
              //           setState(() {});
              //         })
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_rounded,
                    color: AppColors.kASDCPrimaryColor,
                    size: 20.w,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    '\$${widget.wholeSalePrice}',
                    style: TextStyles.textStyle12.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.kASDCPrimaryColor),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  AppDefaultButton(
                    color: AppColors.kLightGrey,
                    height: 27.w,
                    width: 27.w,
                    noFuture: true,
                    onPressed: () {
                      if (wholeSaleCounter.value > widget.minWhole) {
                        wholeSaleCounter.value--;
                        widget.wholeCount.value--;
                        widget.totalWholePrice.value =
                            (widget.totalWholePrice.value -
                                double.parse(widget.wholeSalePrice));
                      }
                    },
                    icon: Icon(
                      Icons.remove,
                      size: 25.w,
                    ),
                    title: '',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  ValueListenableBuilder(
                    valueListenable: wholeSaleCounter,
                    builder: (BuildContext context, int value, Widget? child) {
                      return Text(
                        wholeSaleCounter.value.toString(),
                        style: TextStyles.textStyle16.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  AppDefaultButton(
                    color: AppColors.kASDCPrimaryColor.withOpacity(0.2),
                    height: 27.w,
                    width: 27.w,
                    noFuture: true,
                    onPressed: () {
                      if (wholeSaleCounter.value < widget.maxWhole) {
                        wholeSaleCounter.value++;
                        widget.wholeCount.value++;
                        widget.totalWholePrice.value =
                            (widget.totalWholePrice.value +
                                double.parse(widget.wholeSalePrice));
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      size: 25.w,
                      color: AppColors.kASDCPrimaryColor,
                    ),
                    title: '',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'الكمية بالجملة',
                    style: TextStyles.textStyle12.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_rounded,
                    color: AppColors.kASDCPrimaryColor,
                    size: 20.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    '\$${widget.retailPrice}',
                    style: TextStyles.textStyle12.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.kASDCPrimaryColor),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  AppDefaultButton(
                    color: AppColors.kLightGrey,
                    height: 27.w,
                    width: 27.w,
                    noFuture: true,
                    onPressed: () {
                      if (retailCounter.value > widget.minRetail) {
                        retailCounter.value--;
                        widget.retailCount.value--;
                        widget.totalRetailPrice.value =
                            (widget.totalRetailPrice.value -
                                double.parse(widget.retailPrice));
                      }
                    },
                    icon: Icon(
                      Icons.remove,
                      size: 25.w,
                    ),
                    title: '',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  ValueListenableBuilder(
                    valueListenable: retailCounter,
                    builder: (BuildContext context, int value, Widget? child) {
                      return Text(
                        retailCounter.value.toString(),
                        style: TextStyles.textStyle16.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  AppDefaultButton(
                    color: AppColors.kASDCPrimaryColor.withOpacity(0.2),
                    height: 27.w,
                    width: 27.w,
                    noFuture: true,
                    onPressed: () {
                      if (retailCounter.value < widget.maxRetail) {
                        retailCounter.value++;
                        widget.retailCount.value++;
                        widget.totalRetailPrice.value =
                            (widget.totalRetailPrice.value +
                                double.parse(widget.retailPrice));
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      size: 25.w,
                      color: AppColors.kASDCPrimaryColor,
                    ),
                    title: '',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'الكمية بالمفرد',
                    style: TextStyles.textStyle12.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            width: 10.w,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.w),
            child: MyCachedNetworkImage(
              width: 60.w,
              height: 60.w,
              url: widget.itemImage,
              errorIcon: Icon(
                Icons.image,
                size: 20.w,
                color: AppColors.kASDCPrimaryColor,
              ),
              loadingWidth: 10.w,
            ),
          ),
        ],
      ),
    );
  }
}
