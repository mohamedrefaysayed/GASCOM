import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/utils/time_date_handler.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/core/widgets/app_loading_button.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/home/data/models/orders_model.dart';
import 'package:dinar_store/features/home/presentation/view_model/order_cubit/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderColumn extends StatelessWidget {
  const OrderColumn({super.key, required this.order});

  final GascomOrder order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: order.status == "reviewing"
            ? AppColors.kLightGrey
            : order.status == "preparing"
                ? AppColors.kLightOrang
                : order.status == "delivered"
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
            "${order.id}   : رقم الطلب",
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
                "${order.agentName}",
                style: TextStyles.textStyle16.copyWith(
                  fontSize: 16.w,
                  fontWeight: FontWeight.w900,
                  color: AppColors.kASDCPrimaryColor,
                ),
              ),
              Text(
                " : أسم الوكيل",
                style: TextStyles.textStyle16.copyWith(
                  fontSize: 16.w,
                  fontWeight: FontWeight.w900,
                  color: AppColors.kASDCPrimaryColor,
                ),
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
                  color: order.status == "reviewing"
                      ? AppColors.kGrey
                      : order.status == "preparing"
                          ? AppColors.kOrange
                          : order.status == "delivered"
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
          if (order.status == "reviewing")
            BlocConsumer<OrderCubit, OrderState>(
              listener: (context, state) {
                if (state is CancelOrderSuccess) {
                  context.showMessageSnackBar(
                      message: "تم الغاء الطلب بنجاح", isBottomNavBar: true);
                  context.read<OrderCubit>().getAllOrders();
                }
                if (state is CancelOrderFailuer) {
                  context.showMessageSnackBar(
                      message: state.errMessage, isBottomNavBar: true);
                }
              },
              builder: (context, state) {
                if (state is CancelOrderLoading) {
                  if (state.orderId == order.id.toString()) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: AppLoadingButton(
                        height: 40.h,
                        width: 50.w,
                      ),
                    );
                  } else {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: AppDefaultButton(
                        height: 40.h,
                        width: 50.w,
                        color: AppColors.kASDCPrimaryColor,
                        onPressed: () {
                          context.read<OrderCubit>().cancelOrder(
                                orderId: order.id.toString(),
                              );
                        },
                        title: "الغاء",
                        textStyle: TextStyles.textStyle16.copyWith(
                          color: AppColors.kWhite,
                        ),
                      ),
                    );
                  }
                }
                return Align(
                  alignment: Alignment.centerLeft,
                  child: AppDefaultButton(
                    height: 40.h,
                    width: 50.w,
                    color: AppColors.kASDCPrimaryColor,
                    onPressed: () {
                      context.read<OrderCubit>().cancelOrder(
                            orderId: order.id.toString(),
                          );
                    },
                    title: "الغاء",
                    textStyle: TextStyles.textStyle16.copyWith(
                      color: AppColors.kWhite,
                    ),
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}
