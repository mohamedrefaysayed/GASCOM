import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/utils/time_date_handler.dart';
import 'package:dinar_store/features/home/data/models/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OldOrderColumn extends StatelessWidget {
  const OldOrderColumn({super.key, required this.order});

  final GascomOrder order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: order.status == "delivered"
            ? AppColors.kLightGreen
            : AppColors.kLightRed,
        borderRadius: BorderRadius.circular(15.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "رقم الطلب : ${order.id}",
            style: TextStyles.textStyle16.copyWith(
              fontSize: 16.w,
              fontWeight: FontWeight.w900,
              color: AppColors.kASDCPrimaryColor,
            ),
            textDirection: TextDirection.rtl,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${order.agentName}",
                style: TextStyles.textStyle16.copyWith(
                  fontSize: 16.w,
                  fontWeight: FontWeight.w900,
                  color: AppColors.kASDCPrimaryColor,
                ),
                textDirection: TextDirection.rtl,
              ),
              Text(
                "الأسم : ",
                style: TextStyles.textStyle16.copyWith(
                  fontSize: 16.w,
                  fontWeight: FontWeight.w900,
                  color: AppColors.kASDCPrimaryColor,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          Text(
            "${MyTimeDate.getMessageTime(context: context, time: DateTime.parse(order.createdAt!).millisecondsSinceEpoch.toString())}   : تاريخ الطلب",
            style: TextStyles.textStyle16.copyWith(
              fontSize: 16.w,
              fontWeight: FontWeight.w900,
              color: AppColors.kASDCPrimaryColor,
            ),
          ),
          Text(
            "العدد : ${order.noDisks}",
            style: TextStyles.textStyle16.copyWith(
              fontSize: 16.w,
              fontWeight: FontWeight.w900,
              color: AppColors.kASDCPrimaryColor,
            ),
            textDirection: TextDirection.rtl,
          ),
          Text(
            "السعر : ${order.price}",
            style: TextStyles.textStyle16.copyWith(
              fontSize: 16.w,
              fontWeight: FontWeight.w900,
              color: AppColors.kASDCPrimaryColor,
            ),
            textDirection: TextDirection.rtl,
          ),
          Text(
            "الاجمالى : ${order.totalPrice}",
            style: TextStyles.textStyle16.copyWith(
              fontSize: 16.w,
              fontWeight: FontWeight.w900,
              color: AppColors.kASDCPrimaryColor,
            ),
            textDirection: TextDirection.rtl,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                order.status == "delivered" ? "تم التوصيل" : "تم الالغاء",
                style: TextStyles.textStyle16.copyWith(
                  fontSize: 16.w,
                  fontWeight: FontWeight.w900,
                  color: order.status == "delivered"
                      ? AppColors.kGreen
                      : AppColors.kRed,
                ),
              ),
              Text(
                "   : حالة الطلب",
                style: TextStyles.textStyle16.copyWith(
                  fontSize: 16.w,
                  fontWeight: FontWeight.w900,
                  color: AppColors.kASDCPrimaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
