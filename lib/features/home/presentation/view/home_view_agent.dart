// ignore_for_file: use_build_context_synchronously

import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/auth/presentation/view_model/location_cubit/cubit/location_cubit.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/adds_view.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cards/agent_order_card.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/all_companies_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view_model/ads_cubit/ads_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/agent_orders_cubit/agent_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewAgent extends StatefulWidget {
  const HomeViewAgent({super.key});

  @override
  State<HomeViewAgent> createState() => _HomeViewAgentState();
}

class _HomeViewAgentState extends State<HomeViewAgent>
    with AutomaticKeepAliveClientMixin {
  ValueNotifier<int> counter = ValueNotifier<int>(1);

  @override
  void initState() {
    context.read<LocationCubit>().getCurrentLocation(context: context);
    context.read<AgentOrderCubit>().getAllAgentOrders();
    context.read<AdsCubit>().getAllAds();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<AdsCubit>().getAllAds();
        await context.read<AgentOrderCubit>().getAllAgentOrders();
      },
      child: SafeArea(
        child: ScaffoldMessenger(
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: ListView(
                children: [
                  const AddsView(),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: Text(
                      "كل يوم زبائنك تزيد",
                      style: TextStyles.textStyle24.copyWith(
                        color: AppColors.kASDCPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const GeneralDivider(),
                  BlocBuilder<AgentOrderCubit, AgentOrderState>(
                    builder: (context, state) {
                      if (state is GetagentsOrdersLoading) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: const AllCompaniesPlaceHolder(),
                        );
                      }
                      if (state is GetagentsOrdersFailuer) {
                        return Text(
                          "حدث خطأ",
                          style: TextStyles.textStyle18,
                        );
                      }
                      return AgentOrderCubit
                              .agentOrdersModel!.orders!.isNotEmpty
                          ? Column(
                              children: [
                                Center(
                                  child: Text(
                                    "${AgentOrderCubit.agentOrdersModel!.orders!.length}     الطلبــــــات",
                                    style: TextStyles.textStyle18.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: AgentOrderCubit
                                        .agentOrdersModel!.orders!.length,
                                    itemBuilder: (context, index) =>
                                        AgentOrderCard(
                                          order: AgentOrderCubit
                                              .agentOrdersModel!.orders![index],
                                        )),
                              ],
                            )
                          : SizedBox(
                              height: 300.h,
                              child: Center(
                                child: Text(
                                  "لا يوجد طلبات حالياً",
                                  style: TextStyles.textStyle18,
                                ),
                              ),
                            );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
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
