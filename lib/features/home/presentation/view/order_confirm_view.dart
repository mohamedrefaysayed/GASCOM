// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, use_build_context_synchronously

import 'package:dinar_store/core/animations/right_slide_transition.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/core/widgets/app_loading_button.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/home/presentation/view/bottom_nav_view.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/maps/order_location_map.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/rows/order_confirm_action_row.dart';
import 'package:dinar_store/features/home/presentation/view_model/cart_cubit/cubit/cart_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/order_cubit/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderConfirmView extends StatefulWidget {
  const OrderConfirmView({super.key});

  @override
  State<OrderConfirmView> createState() => _OrderConfirmViewState();
}

class _OrderConfirmViewState extends State<OrderConfirmView> {
  @override
  void initState() {
    OrderCubit.pickedTime = null;
    OrderCubit.initialTime = TimeOfDay.now();
    OrderCubit.initialTime.replacing(minute: 30);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(onRefresh: () async {
        await context.read<CartCubit>().getAllItems();
      }, child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 30.w, left: 30.w, top: 40.h),
                child: Text(
                  'إتمام الشراء',
                  style: TextStyles.textStyle16.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.w,
                  ),
                ),
              ),
              const GeneralDivider(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      OrderConfirmActionRow(
                        onTap: () async {
                          OrderCubit.pickedTime = await showTimePicker(
                            context: context,
                            initialTime:
                                OrderCubit.pickedTime ?? OrderCubit.initialTime,
                          );
                          context.read<OrderCubit>().emit(OrderInitial());
                        },
                        title: "وقت التوصيل",
                        buttonTitle: 'تغيير',
                        buttonWidth: 70.w,
                        subTitle: OrderCubit.pickedTime != null
                            ? "${OrderCubit.pickedTime!.minute} : ${OrderCubit.pickedTime!.hour}"
                            : "${OrderCubit.initialTime.minute} : ${OrderCubit.initialTime.hour}",
                      ),
                      const GeneralDivider(),
                      OrderConfirmActionRow(
                        onTap: () async {
                          Navigator.push(
                              context,
                              RightSlideTransition(
                                page: const OrderLocationMap(),
                              ));
                        },
                        title: "التوصيل إلى",
                        buttonTitle: 'أختر الموقع',
                        buttonWidth: 100.w,
                        subTitle: OrderCubit.currentAddress,
                      ),
                      const GeneralDivider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                'إضافة ملاحظات',
                                style: TextStyles.textStyle14
                                    .copyWith(fontWeight: FontWeight.w700),
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextField(
                            minLines: 4,
                            maxLines: null,
                            textDirection: TextDirection.rtl,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            decoration: InputDecoration(
                                hintTextDirection: TextDirection.rtl,
                                hintText: 'أضف ملاحظاتك',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.w),
                                    borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.05),
                                    ))),
                          ),
                        ],
                      ),
                      const GeneralDivider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                'إختر طريقة الدفع',
                                style: TextStyles.textStyle14
                                    .copyWith(fontWeight: FontWeight.w700),
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RadioListTile(
                            value: "عند التوصيل",
                            groupValue: OrderCubit.payment,
                            onChanged: (newValue) {
                              OrderCubit.payment = newValue!;
                              context.read<OrderCubit>().emit(OrderInitial());
                            },
                            title: Row(
                              children: [
                                const Spacer(),
                                Text(
                                  "الدفع عند الاستلام",
                                  style: TextStyles.textStyle14,
                                ),
                              ],
                            ),
                          ),
                          RadioListTile(
                            value: "الدفع عند الاستلام",
                            groupValue: OrderCubit.payment,
                            onChanged: (newValue) {
                              OrderCubit.payment = newValue!;
                              context.read<OrderCubit>().emit(OrderInitial());
                            },
                            title: Row(
                              children: [
                                const Spacer(),
                                Text(
                                  "الدفع عن طريق الفيزا",
                                  style: TextStyles.textStyle14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const GeneralDivider(),
                      Row(
                        children: [
                          Text(
                            "\$${CartCubit.finalPrice}",
                            style: TextStyles.textStyle14.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'السعر النهائى',
                            style: TextStyles.textStyle14.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.kASDCPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      const GeneralDivider(),
                      BlocConsumer<OrderCubit, OrderState>(
                        listener: (context, state) {
                          if (state is AddOrderFailuer) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                messageSnackBar(message: state.errMessage));
                          }
                          if (state is AddOrderSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                messageSnackBar(message: "تم إرسال الطلب"));
                            Navigator.of(context).popUntil(
                                ModalRoute.withName(BottomNavBarView.id));
                            context.read<OrderCubit>().getAllOrders();
                          }
                        },
                        builder: (context, state) {
                          if (state is AddToOrdersLoading) {
                            return const AppLoadingButton();
                          }
                          return AppDefaultButton(
                            onPressed: () async {
                              await context.read<OrderCubit>().storeOrder(
                                    status: 0,
                                    discount: CartCubit.totalDiscount,
                                    tax: 14,
                                    price: CartCubit.totalPrice,
                                    addressId: 1,
                                  );
                            },
                            color: AppColors.kASDCPrimaryColor,
                            title: "إتمام الطلب",
                            textStyle: TextStyles.textStyle16.copyWith(
                              color: AppColors.kWhite,
                              fontSize: 16.w,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
