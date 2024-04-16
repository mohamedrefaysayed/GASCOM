import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/core/widgets/app_loading_button.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/home/data/models/orders_model.dart';
import 'package:dinar_store/features/home/presentation/view_model/agent_orders_actions_cubit/agent_order_actions_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/agent_orders_cubit/agent_order_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/order_cubit/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgentOrderCard extends StatelessWidget {
  const AgentOrderCard({
    super.key,
    required this.order,
  });

  final GascomOrder order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.w,
        horizontal: 30.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(15.w),
          boxShadow: [
            BoxShadow(
              color: AppColors.kGrey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3.w),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 10.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${order.customerName}",
                  style: TextStyles.textStyle16.copyWith(
                    color: AppColors.kASDCPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  " : الأسم",
                  style: TextStyles.textStyle16.copyWith(
                    color: AppColors.kASDCPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
            Text(
              "${order.noDisks} :  العدد",
              style: TextStyles.textStyle14.copyWith(
                color: AppColors.kASDCPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${order.price!} : السعر ",
              style: TextStyles.textStyle14.copyWith(
                color: AppColors.kASDCPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${int.parse(order.noDisks!) * order.price!} :  السعر الكلى",
              style: TextStyles.textStyle14.copyWith(
                color: AppColors.kASDCPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocConsumer<AgentOrderActionsCubit, AgentOrderActionsState>(
                  listener: (context, state) {
                    if (state is RejectOrderActionsSuccess) {
                      context.read<AgentOrderCubit>().getAllAgentOrders();
                      context.read<OrderCubit>().getAllOrders();
                      ScaffoldMessenger.of(context).showSnackBar(
                        messageSnackBar(
                          isBottomNavBar: true,
                          message: "تم رفض الطلب بنجاح",
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is RejectOrderActionsLoading) {
                      if (state.orderId == order.id.toString()) {
                        return AppLoadingButton(
                          width: 100.w,
                        );
                      } else {
                        return AppDefaultButton(
                          height: 40.h,
                          width: 100.w,
                          color: AppColors.kRed,
                          textStyle: TextStyles.textStyle14.copyWith(
                            color: AppColors.kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {},
                          title: "رفض",
                        );
                      }
                    }
                    return AppDefaultButton(
                      height: 40.h,
                      width: 100.w,
                      color: AppColors.kRed,
                      textStyle: TextStyles.textStyle14.copyWith(
                        color: AppColors.kWhite,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () async {
                        await context
                            .read<AgentOrderActionsCubit>()
                            .rejectOrder(orderId: order.id.toString());
                      },
                      title: "رفض",
                    );
                  },
                ),
                BlocConsumer<AgentOrderActionsCubit, AgentOrderActionsState>(
                  listener: (context, state) {
                    if (state is ApproveOrderActionsSuccess) {
                      context.read<AgentOrderCubit>().getAllAgentOrders();
                      context.read<OrderCubit>().getAllOrders();
                      ScaffoldMessenger.of(context).showSnackBar(
                        messageSnackBar(
                          isBottomNavBar: true,
                          message: "تم قبول الطلب بنجاح",
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ApproveOrderActionsLoading) {
                      if (state.orderId == order.id.toString()) {
                        return AppLoadingButton(
                          height: 40.h,
                          width: 100.w,
                        );
                      } else {
                        return AppDefaultButton(
                          width: 100.w,
                          color: AppColors.kDarkGreen,
                          textStyle: TextStyles.textStyle14.copyWith(
                            color: AppColors.kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {},
                          title: "قبول",
                        );
                      }
                    }
                    return AppDefaultButton(
                      height: 40.h,
                      width: 100.w,
                      color: AppColors.kDarkGreen,
                      textStyle: TextStyles.textStyle14.copyWith(
                        color: AppColors.kWhite,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () async {
                        await context
                            .read<AgentOrderActionsCubit>()
                            .approveOrder(orderId: order.id.toString());
                      },
                      title: "قبول",
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
