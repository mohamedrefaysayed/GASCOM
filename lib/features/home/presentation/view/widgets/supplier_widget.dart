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
    super.initState();

    context.read<OrderCubit>().getSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is GetSuppliersSuccess) {
          if (state.suppliersModel.agents == null ||
              state.suppliersModel.agents!.isEmpty) {
            context.showMessageSnackBar(
              message: "لا يوجد وكلاء قريبين منك",
            );
          }
        }
        if (state is AddOrderSuccess) {
          OrderCubit.selectedValue = null;
          context.read<OrderCubit>().emit(OrderInitial());
          widget.counter.value = 1;
          context.read<OrderCubit>().getAllOrders();
          context.read<OrderCubit>().getSuppliers();

          context.showMessageSnackBar(
            message: "تم إرسال الطلب",
          );
        }
        if (state is AddOrderFailuer) {
          context.showMessageSnackBar(
            message: "لم يتم إرسال الطلب",
          );
        }
        if (state is GetSuppliersFailuer) {
          context.showMessageSnackBar(
            message: state.errMessage,
          );
        }
      },
      builder: (context, state) {
        if (state is GetSuppliersLoading) {
          return const CircularProgressIndicator();
        }
        if (state is GetSuppliersFailuer) {
          return Text(
            "حدث خطأ أثناء جلب أقرب الوكلاء ",
            style: TextStyles.textStyle16.copyWith(
              fontWeight: FontWeight.bold,
            ),
          );
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
            Text(
              "(الوكلاء فى نفس منطقتك الجغرافية)",
              style: TextStyles.textStyle12.copyWith(),
            ),
            const GeneralDivider(),
            (OrderCubit.suppliersModel != null &&
                    OrderCubit.suppliersModel!.agents!.isNotEmpty)
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
                          .map(
                            (Agents item) => DropdownMenuItem<String>(
                              value: item.mobNo,
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
                                      textDirection: TextDirection.rtl,
                                    ),
                                    Text(
                                      "يبعد عنك :  ${(item.distance ?? 0) >= 1000 ? ((item.distance ?? 0) / 1000) : (item.distance ?? 0)} ${(item.distance ?? 0) >= 1000 ? "كم" : "متر"}",
                                      style: TextStyle(
                                        fontSize: 14.w,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.kBlack,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      textDirection: TextDirection.rtl,
                                    ),
                                    Text(
                                      "سعر الاسطوانة :  ${item.price}",
                                      style: TextStyle(
                                        fontSize: 14.w,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.kBlack,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      value: OrderCubit.selectedValue,
                      onChanged: (String? value) {
                        OrderCubit.selectedValue = value;
                        context.read<OrderCubit>().emit(OrderInitial());
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 100.h,
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
                        width: 300.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: AppColors.kWhite,
                        ),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: WidgetStateProperty.all(6),
                          thumbVisibility: WidgetStateProperty.all(true),
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
                : Stack(
                    children: [
                      DropdownButtonHideUnderline(
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
                              .map(
                                (Agents item) => DropdownMenuItem<String>(
                                  value: item.mobNo,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          item.name!,
                                          style: TextStyle(
                                            fontSize: 14.w,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.kBlack,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          textDirection: TextDirection.rtl,
                                        ),
                                        Text(
                                          "يبعد عنك :  ${(item.distance ?? 0) >= 1000 ? ((item.distance ?? 0) / 1000) : (item.distance ?? 0)} ${(item.distance ?? 0) >= 1000 ? "كم" : "متر"}",
                                          style: TextStyle(
                                            fontSize: 14.w,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.kBlack,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          textDirection: TextDirection.rtl,
                                        ),
                                        Text(
                                          "سعر الاسطوانة :  ${item.price}",
                                          style: TextStyle(
                                            fontSize: 14.w,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.kBlack,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          value: OrderCubit.selectedValue,
                          onChanged: (String? value) {
                            OrderCubit.selectedValue = value;
                            context.read<OrderCubit>().emit(OrderInitial());
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 100.h,
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
                            width: 300.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColors.kWhite,
                            ),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: WidgetStateProperty.all(6),
                              thumbVisibility: WidgetStateProperty.all(true),
                            ),
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            height: 80.h,
                            padding: EdgeInsets.only(left: 14.w, right: 14.w),
                            selectedMenuItemBuilder: (context, child) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.kASDCPrimaryColor
                                      .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(14.w),
                                ),
                                child: child,
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: InkWell(
                          onTap: () {
                            context.showMessageSnackBar(
                              message: "لا يوجد وكلاء قريبين منك حاليا",
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.w),
                            ),
                            height: 100,
                            width: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
