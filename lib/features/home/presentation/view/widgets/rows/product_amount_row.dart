import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cachedNetworkImage/my_cached_nework_Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductAmountRow extends StatefulWidget {
  const ProductAmountRow(
      {super.key,
      required this.retailPrice,
      required this.wholeSalePrice,
      required this.title});

  final String retailPrice;
  final String wholeSalePrice;
  final String title;

  @override
  State<ProductAmountRow> createState() => _ProductAmountRowState();
}

class _ProductAmountRowState extends State<ProductAmountRow> {
  bool value = false;
  int wholeSaleCounter = 0;
  int retailCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w),
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
                    height: 30.w,
                    width: 30.w,
                    noFuture: true,
                    onPressed: () {
                      setState(() {
                        if (wholeSaleCounter > 0) {
                          wholeSaleCounter--;
                        }
                      });
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
                  Text(
                    wholeSaleCounter.toString(),
                    style: TextStyles.textStyle16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  AppDefaultButton(
                    color: AppColors.kASDCPrimaryColor.withOpacity(0.2),
                    height: 30.w,
                    width: 30.w,
                    noFuture: true,
                    onPressed: () {
                      setState(() {
                        if (wholeSaleCounter < 100) {
                          wholeSaleCounter++;
                        }
                      });
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
                    height: 30.w,
                    width: 30.w,
                    noFuture: true,
                    onPressed: () {
                      setState(() {
                        if (retailCounter > 0) {
                          retailCounter--;
                        }
                      });
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
                  Text(
                    retailCounter.toString(),
                    style: TextStyles.textStyle16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  AppDefaultButton(
                    color: AppColors.kASDCPrimaryColor.withOpacity(0.2),
                    height: 30.w,
                    width: 30.w,
                    noFuture: true,
                    onPressed: () {
                      setState(() {
                        if (retailCounter < 100) {
                          retailCounter++;
                        }
                      });
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
              width: 80.w,
              height: 80.w,
              url: 'images/y3OhzHofEVROPO0MP5k8xRQ4I5EFg6M28FARKfwZ.jpg',
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
