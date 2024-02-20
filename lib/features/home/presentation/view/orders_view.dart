import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/all_companies_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/rows/order_row.dart';
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
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<OrderCubit>().getAllOrders();
        },
        child: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
            if (state is OrderFailuer) {
              ScaffoldMessenger.of(context).showSnackBar(messageSnackBar(
                  message: state.errMessage, isBottomNavBar: true));
            }
            if (state is AddOrderFailuer) {
              ScaffoldMessenger.of(context).showSnackBar(messageSnackBar(
                  message: state.errMessage, isBottomNavBar: true));
            }
            if (state is DeleteOrderSuccess) {
              OrderCubit.ordersModel = state.ordersModel;
              ScaffoldMessenger.of(context).showSnackBar(
                  messageSnackBar(message: "تم الحذف", isBottomNavBar: true));
            }
            if (state is DeleteOrderFailuer) {
              ScaffoldMessenger.of(context).showSnackBar(messageSnackBar(
                  message: state.errMessage, isBottomNavBar: true));
            }
          },
          builder: (context, state) {
            if (state is OrderLoading) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: const AllCompaniesPlaceHolder(),
              );
            }
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
            return (OrderCubit.ordersModel != null &&
                    OrderCubit.ordersModel!.currentOrders!.isNotEmpty)
                ? Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(right: 30.w, left: 30.w, top: 40.h),
                        child: Text(
                          'الطلبــــــات',
                          style: TextStyles.textStyle16.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.w,
                          ),
                        ),
                      ),
                      const GeneralDivider(),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          children: [
                            ListView.builder(
                              reverse: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: OrderCubit
                                          .ordersModel!.currentOrders!.length >
                                      2
                                  ? OrderCubit
                                      .ordersModel!.currentOrders!.length
                                  : 2,
                              itemBuilder: (context, index) {
                                return OrderRow(
                                    order: OrderCubit
                                        .ordersModel!.currentOrders![index]);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
