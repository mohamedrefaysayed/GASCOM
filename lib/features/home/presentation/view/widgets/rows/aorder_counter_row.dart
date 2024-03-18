import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersCounterRow extends StatelessWidget {
  const OrdersCounterRow({
    super.key,
    required this.counter,
  });

  final ValueNotifier<int> counter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            if (counter.value > 1) {
              counter.value = counter.value - 1;
            }
          },
          child: Container(
            height: 35.w,
            width: 35.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.kOrange,
            ),
            child: Icon(
              Icons.remove_circle_outline_rounded,
              color: AppColors.kWhite,
              size: 30.w,
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: counter,
          builder: (context, value, child) => Text(
            value.toString(),
            style: TextStyles.textStyle18.copyWith(
              color: AppColors.kWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            counter.value = counter.value + 1;
          },
          child: Container(
            height: 35.w,
            width: 35.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.kOrange,
            ),
            child: Icon(
              Icons.add_circle_outline_rounded,
              color: AppColors.kWhite,
              size: 30.w,
            ),
          ),
        ),
      ],
    );
  }
}
