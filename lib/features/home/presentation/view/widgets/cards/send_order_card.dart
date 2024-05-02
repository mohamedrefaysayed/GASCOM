import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/home/data/models/suppliers_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/rows/aorder_counter_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendOrderCard extends StatelessWidget {
  const SendOrderCard({
    super.key,
    required this.supplier,
    required this.counter,
  });

  final Agents supplier;
  final ValueNotifier<int> counter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.w),
      child: Container(
        height: 210.h,
        width: 250.w,
        decoration: BoxDecoration(
          color: AppColors.kASDCPrimaryColor,
          borderRadius: BorderRadius.circular(15.w),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 10.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${supplier.name} ارسال الى',
              style: TextStyles.textStyle16.copyWith(
                color: AppColors.kWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'سعر الأسطوانة',
              style: TextStyles.textStyle14.copyWith(
                color: AppColors.kOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              supplier.price ?? "لا يوجد سعر",
              style: TextStyles.textStyle14.copyWith(
                color: AppColors.kWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            OrdersCounterRow(
              counter: counter,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "السعر الكلى",
              style: TextStyles.textStyle14.copyWith(
                color: AppColors.kOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            ValueListenableBuilder(
              valueListenable: counter,
              builder: (BuildContext context, int value, Widget? child) => Text(
                "${value * (supplier.price != null ? int.parse(supplier.price!) : 0)}",
                style: TextStyles.textStyle18.copyWith(
                  color: AppColors.kWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
