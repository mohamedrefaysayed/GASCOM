import 'package:dinar_store/core/animations/right_slide_transition.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/utils/time_date_handler.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/features/home/data/models/orders_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/order_follow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgentOrderColumn extends StatelessWidget {
  const AgentOrderColumn({super.key, required this.order});

  final GascomOrder order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(15.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${order.id}   : رقم الطلب",
            style: TextStyles.textStyle16.copyWith(
              fontSize: 16.w,
              fontWeight: FontWeight.w900,
              color: AppColors.kASDCPrimaryColor,
            ),
          ),
          Text(
            "${order.customerName}   : الأسم",
            style: TextStyles.textStyle16.copyWith(
              fontSize: 16.w,
              fontWeight: FontWeight.w900,
              color: AppColors.kASDCPrimaryColor,
            ),
          ),
          Text(
            "${order.noDisks}   : العدد",
            style: TextStyles.textStyle16.copyWith(
              fontSize: 16.w,
              fontWeight: FontWeight.w900,
              color: AppColors.kASDCPrimaryColor,
            ),
          ),
          Text(
            "${order.price}   : السعر",
            style: TextStyles.textStyle16.copyWith(
              fontSize: 16.w,
              fontWeight: FontWeight.w900,
              color: AppColors.kASDCPrimaryColor,
            ),
          ),
          Text(
            "${order.totalPrice}   : الاجمالى",
            style: TextStyles.textStyle16.copyWith(
              fontSize: 16.w,
              fontWeight: FontWeight.w900,
              color: AppColors.kASDCPrimaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                order.status == "reviewing"
            ? "قيد المراجعة"
            : order.status == "preparing"
                ? "قيد التحضير"
                : order.status == "delivered"
                    ? "تم التوصيل"
                    : "تم الالغاء",
                style: TextStyles.textStyle16.copyWith(
                  fontSize: 16.w,
                  fontWeight: FontWeight.w900,
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
          SizedBox(
            height: 15.h,
          ),
          Text(
            MyTimeDate.getMessageTime(
                context: context,
                time: DateTime.parse(order.createdAt!)
                    .millisecondsSinceEpoch
                    .toString()),
            style: TextStyles.textStyle16.copyWith(
              fontSize: 14.w,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          AppDefaultButton(
            width: 300.w,
            color: AppColors.kASDCPrimaryColor,
            onPressed: () {
              Navigator.push(
                  context,
                  RightSlideTransition(
                    page: OrderFollow(order: order),
                  ));
            },
            title: 'متابعة الطلب',
            textStyle: TextStyles.textStyle16.copyWith(
              color: AppColors.kWhite,
              fontSize: 16.w,
            ),
          )
        ],
      ),
    );
  }
}
