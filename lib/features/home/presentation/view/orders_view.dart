import 'package:dinar_store/core/animations/left_slide_transition.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/genrall.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/home/presentation/view/old_orders_view.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/columns/agent_order_column.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/columns/order_column.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/all_companies_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view_model/order_cubit/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<OrderCubit>().getAllOrders();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 30.w, left: 30.w, top: 40.h),
            child: Row(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Text(
                  isCustomer ? 'الطلبــــــات' : 'الطلبــــــات الحالية',
                  style: TextStyles.textStyle16.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.w,
                  ),
                ),
                Spacer(
                  flex: isCustomer ? 2 : 1,
                ),
                if (!isCustomer)
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        LeftSlideTransition(
                          page: const OldOrdersView(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.history,
                      size: 25.w,
                      color: AppColors.kASDCPrimaryColor,
                    ),
                  )
              ],
            ),
          ),
          const GeneralDivider(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<OrderCubit>().getAllOrders();
              },
              child: BlocConsumer<OrderCubit, OrderState>(
                listener: (context, state) {
                  if (state is OrderFailuer) {
                    context.showMessageSnackBar(
                      message: state.errMessage,
                    );
                  }
                  if (state is AddOrderFailuer) {
                    context.showMessageSnackBar(
                      message: state.errMessage,
                    );
                  }
                  if (state is DeleteOrderSuccess) {
                    OrderCubit.ordersModel = state.ordersModel;

                    context.showMessageSnackBar(
                      message: "تم الحذف",
                    );
                  }
                  if (state is DeleteOrderFailuer) {
                    context.showMessageSnackBar(
                      message: state.errMessage,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is OrderFailuer) {
                    return ListView(
                      children: [
                        SizedBox(
                          height: 300.h,
                          child: Center(
                            child: Text(
                              "حدث خطأ",
                              style: TextStyles.textStyle16.copyWith(
                                fontSize: 16.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is OrderLoading) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: const AllCompaniesPlaceHolder(),
                    );
                  }

                  return (OrderCubit.ordersModel != null &&
                          OrderCubit.ordersModel!.orders!.isNotEmpty)
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: OrderCubit.ordersModel!.orders!.length,
                          itemBuilder: (context, index) {
                            return isCustomer
                                ? OrderColumn(
                                    order:
                                        OrderCubit.ordersModel!.orders![index],
                                  )
                                : AgentOrderColumn(
                                    order:
                                        OrderCubit.ordersModel!.orders![index],
                                  );
                          },
                        )
                      : ListView(
                          children: [
                            SizedBox(
                              height: 300.h,
                            ),
                            Center(
                              child: Text(
                                "لا توجد طلبات",
                                style: TextStyles.textStyle18,
                              ),
                            ),
                          ],
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
