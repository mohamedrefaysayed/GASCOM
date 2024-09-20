// ignore_for_file: use_build_context_synchronously

import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/genrall.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/core/widgets/app_loading_button.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/auth/presentation/view_model/location_cubit/cubit/location_cubit.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/Supplier_widget.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/adds_view.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cards/send_order_card.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view_model/ads_cubit/ads_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/order_cubit/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  ValueNotifier<int> counter = ValueNotifier<int>(1);

  @override
  void initState() {
    context.read<LocationCubit>().getCurrentLocation(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<AdsCubit>().getAllAds();
        await context.read<OrderCubit>().getSuppliers();
        await context
            .read<LocationCubit>()
            .getCurrentLocation(context: context);
      },
      child: SafeArea(
        child: ScaffoldMessenger(
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: ListView(
                children: [
                  Column(
                    children: [
                      const AddsView(),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "إملئ غازك وأنت مرتاح",
                        style: TextStyles.textStyle24.copyWith(
                          color: AppColors.kASDCPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const GeneralDivider(),
                      BlocBuilder<LocationCubit, LocationState>(
                        builder: (context, state) {
                          if (state is LocationLoading) {
                            return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.w, vertical: 10.h),
                                child: const AppLoadingButton());
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 10.h),
                            child: Column(
                              children: [
                                AppDefaultButton(
                                  icon: (state is LocationSuccess)
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 25.w,
                                        )
                                      : Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 25.w,
                                        ),
                                  textStyle: TextStyles.textStyle16.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.w,
                                  ),
                                  onPressed: () async {
                                    await context
                                        .read<LocationCubit>()
                                        .getCurrentLocation(context: context);
                                  },
                                  title: 'تغيير موقعي',
                                  color: AppColors.kASDCPrimaryColor,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  LocationCubit.address != null
                                      ? LocationCubit.address!.street!
                                      : "",
                                  style: TextStyles.textStyle16.copyWith(
                                    color: AppColors.kASDCPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.w,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const GeneralDivider(),
                      SupplierWidget(
                        counter: counter,
                      ),
                      const GeneralDivider(),
                      BlocBuilder<OrderCubit, OrderState>(
                        builder: (context, state) {
                          return OrderCubit.selectedValue != null
                              ? SendOrderCard(
                                  supplier: OrderCubit.suppliersModel!.agents!
                                      .firstWhere((element) =>
                                          element.mobNo ==
                                          OrderCubit.selectedValue),
                                  counter: counter,
                                )
                              : const SizedBox();
                        },
                      ),
                      BlocBuilder<OrderCubit, OrderState>(
                        builder: (context, state) {
                          if (state is AddToOrdersLoading) {
                            return const AppLoadingButton();
                          }
                          return AppDefaultButton(
                            color: AppColors.kASDCPrimaryColor,
                            textStyle: TextStyles.textStyle14.copyWith(
                              color: AppColors.kWhite,
                              fontWeight: FontWeight.bold,
                            ),
                            onPressed: () async {
                              if ((OrderCubit.suppliersModel != null &&
                                  OrderCubit
                                      .suppliersModel!.agents!.isNotEmpty )) {
                                if (OrderCubit.selectedValue != null) {
                                  context.read<OrderCubit>().storeOrder(
                                        userPhone: userPhone!,
                                        supplierPhone: OrderCubit
                                            .suppliersModel!.agents!
                                            .firstWhere((agent) =>
                                                agent.mobNo ==
                                                OrderCubit.selectedValue)
                                            .mobNo!,
                                        totalPrice: counter.value *
                                            int.parse(OrderCubit
                                                .suppliersModel!.agents!
                                                .firstWhere((agent) =>
                                                    agent.mobNo ==
                                                    OrderCubit.selectedValue)
                                                .price!),
                                        tubsNumber: counter.value,
                                      );
                                } else {
                                  context.showMessageSnackBar(
                                    message: "أختر موزع",
                                  );
                                }
                              } else {
                                context.showMessageSnackBar(
                                  message:
                                      "لا يوجد وكلاء موزعيين قريبين منك حاليا",
                                );
                              }
                            },
                            title: 'إرسال الطلب',
                          );
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
