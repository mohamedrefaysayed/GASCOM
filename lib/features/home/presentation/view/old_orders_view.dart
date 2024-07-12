import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/columns/old_order_column.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/all_companies_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view_model/order_cubit/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OldOrdersView extends StatefulWidget {
  const OldOrdersView({super.key});

  @override
  State<OldOrdersView> createState() => _OldOrdersViewState();
}

class _OldOrdersViewState extends State<OldOrdersView> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getAllOldOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<OrderCubit>().getAllOldOrders();
        },
        child: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
            if (state is OldOrdersFailuer) {
              ScaffoldMessenger.of(context).showSnackBar(
                messageSnackBar(
                  message: state.errMessage,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is OldOrdersFailuer) {
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
            if (state is OldOrdersLoading) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: const AllCompaniesPlaceHolder(),
              );
            }

            return (OrderCubit.oldOrdersModel != null &&
                    OrderCubit.oldOrdersModel!.orders!.isNotEmpty)
                ? Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(right: 30.w, left: 30.w, top: 40.h),
                        child: Text(
                          'الطلبــــــات الســــــابقة',
                          style: TextStyles.textStyle16.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.w,
                          ),
                        ),
                      ),
                      const GeneralDivider(),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: OrderCubit.oldOrdersModel!.orders!.length,
                          itemBuilder: (context, index) {
                            return OldOrderColumn(
                              order: OrderCubit.oldOrdersModel!.orders![index],
                            );
                          },
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
                          "لا توجد طلبات سابقة",
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
}
