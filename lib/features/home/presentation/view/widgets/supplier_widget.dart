// ignore_for_file: file_names, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/home/data/models/suppliers_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view_model/order_cubit/cubit/order_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupplierWidget extends StatefulWidget {
  const SupplierWidget({
    super.key,
    required this.counter,
  });

  final ValueNotifier<int> counter;

  @override
  State<SupplierWidget> createState() => _SupplierWidgetState();
}

class _SupplierWidgetState extends State<SupplierWidget> {
  @override
  void initState() {
    context.read<OrderCubit>().getSuppliers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is AddOrderSuccess) {
          OrderCubit.selectedValue = null;
          context.read<OrderCubit>().emit(OrderInitial());
          widget.counter.value = 1;
          context.read<OrderCubit>().getAllOrders();
          context.read<OrderCubit>().getSuppliers();

          ScaffoldMessenger.of(context).showSnackBar(messageSnackBar(
            message: "تم إرسال الطلب",
            isBottomNavBar: true,
          ));
        }
        if (state is AddOrderFailuer) {
          ScaffoldMessenger.of(context).showSnackBar(messageSnackBar(
            message: "لم يتم إرسال الطلب",
            isBottomNavBar: true,
          ));
        }
      },
      builder: (context, state) {
        if (state is GetSuppliersLoading) {
          return const CircularProgressIndicator();
        }
        return Column(
          children: [
            Text(
              "قائمة الوكلاء الاقرب اليك",
              style: TextStyles.textStyle20.copyWith(
                color: AppColors.kASDCPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const GeneralDivider(),
            OrderCubit.suppliersModel != null
                ? DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "أختر موزع",
                            style: TextStyle(
                              fontSize: 14.w,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kBlack,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.list,
                            size: 16.w,
                            color: AppColors.kASDCPrimaryColor,
                          ),
                        ],
                      ),
                      items: OrderCubit.suppliersModel!.agents!
                          .map((Agents item) => DropdownMenuItem<String>(
                                value: item.name,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        item.name!,
                                        style: TextStyle(
                                          fontSize: 14.w,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.kBlack,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "يبعد عنك :  ${(item.distanceKm! * 1000).toStringAsFixed(2)} متر",
                                        style: TextStyle(
                                          fontSize: 14.w,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.kBlack,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "سعر الاسطوانة :  ${item.price}",
                                        style: TextStyle(
                                          fontSize: 14.w,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.kBlack,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                      value: OrderCubit.selectedValue,
                      onChanged: (String? value) {
                        OrderCubit.selectedValue = value;
                        context.read<OrderCubit>().emit(OrderInitial());
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 80.h,
                        width: 300.w,
                        padding: EdgeInsets.only(left: 14.w, right: 14.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.w),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: AppColors.kWhite,
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: IconStyleData(
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14.w,
                        iconEnabledColor: AppColors.kBlack,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200.h,
                        width: 300.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: AppColors.kWhite,
                        ),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility: MaterialStateProperty.all(true),
                        ),
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        height: 80.h,
                        padding: EdgeInsets.only(left: 14.w, right: 14.w),
                        selectedMenuItemBuilder: (context, child) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color:
                                  AppColors.kASDCPrimaryColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(14.w),
                            ),
                            child: child,
                          );
                        },
                      ),
                    ),
                  )
                : const CircularProgressIndicator(),
          ],
        );
      },
    );
  }
}
