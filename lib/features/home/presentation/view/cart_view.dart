import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/all_companies_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/rows/cart_item_row.dart';
import 'package:dinar_store/features/home/presentation/view_model/cart_cubit/cubit/cart_cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<CartCubit>().getAllItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<CartCubit>().getAllItems();
        },
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is GetCartFailuer) {
              ScaffoldMessenger.of(context).showSnackBar(messageSnackBar(
                  message: state.errMessage, isBottomNavBar: true));
            }
          },
          builder: (context, state) {
            if (state is GetCartLoading) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(right: 30.w, left: 30.w, top: 40.h),
                      child: Row(
                        children: [
                          const Spacer(
                            flex: 3,
                          ),
                          Text(
                            'ســــــلة المشــــــتريات',
                            style: TextStyles.textStyle16.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.w,
                            ),
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                        ],
                      ),
                    ),
                    const GeneralDivider(),
                    const Expanded(child: AllCompaniesPlaceHolder()),
                  ],
                ),
              );
            }
            if (state is GetCartFailuer) {
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
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 30.w, left: 30.w, top: 40.h),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35.w,
                        height: 35.w,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                height: 15.w,
                                width: 15.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.kASDCPrimaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    CartCubit.cartItemsModel.cart!.length
                                        .toString(),
                                    style: TextStyles.textStyle10
                                        .copyWith(color: AppColors.kWhite),
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 25.w,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      Text(
                        'ســــــلة المشــــــتريات',
                        style: TextStyles.textStyle16.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.w,
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
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
                        itemCount: CartCubit.cartItemsModel.cart!.length,
                        itemBuilder: (context, index) {
                          return CartItemRow(
                            cartItem: CartCubit.cartItemsModel.cart![index],
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 20.h,
                        ),
                        child: DottedBorder(
                          dashPattern: const [6, 6],
                          borderType: BorderType.RRect,
                          radius: Radius.circular(15.w),
                          color: AppColors.kASDCPrimaryColor,
                          strokeWidth: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            child: SizedBox(
                              height: 45.h,
                              child: Row(
                                children: [
                                  AppDefaultButton(
                                    onPressed: () {},
                                    title: "تطبيق",
                                    width: 70.w,
                                    color: AppColors.kASDCPrimaryColor,
                                    textStyle: TextStyles.textStyle12.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.kWhite,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'ادخل كود الخصم',
                                        hintStyle: TextStyles.textStyle14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Container(
                                    height: 30.w,
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.kASDCPrimaryColor,
                                          width: 1.w,
                                        )),
                                    child: Center(
                                      child: Text(
                                        "%",
                                        style: TextStyles.textStyle16.copyWith(
                                          color: AppColors.kASDCPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 20.h,
                        ),
                        child: DottedBorder(
                          dashPattern: const [6, 6],
                          borderType: BorderType.RRect,
                          radius: Radius.circular(15.w),
                          color: AppColors.kASDCPrimaryColor,
                          strokeWidth: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            child: SizedBox(
                              height: 45.h,
                              child: Row(
                                children: [
                                  AppDefaultButton(
                                    onPressed: () {},
                                    title: "تطبيق",
                                    width: 70.w,
                                    color: AppColors.kASDCPrimaryColor,
                                    textStyle: TextStyles.textStyle12.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.kWhite,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'ادخل كود الخصم',
                                        hintStyle: TextStyles.textStyle14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Container(
                                    height: 30.w,
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.kASDCPrimaryColor,
                                          width: 1.w,
                                        )),
                                    child: Center(
                                      child: Text(
                                        "%",
                                        style: TextStyles.textStyle16.copyWith(
                                          color: AppColors.kASDCPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const GeneralDivider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'اجمالي الطلب',
                            style: TextStyles.textStyle16.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 20.h),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "\$${CartCubit.totalPrice}",
                                  style: TextStyles.textStyle14.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'مجموع الشراء',
                                  style: TextStyles.textStyle14.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.kASDCPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  '\$2.29',
                                  style: TextStyles.textStyle14.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'سعر الخصم',
                                  style: TextStyles.textStyle14.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.kASDCPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  '\$0.00',
                                  style: TextStyles.textStyle14.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'سعر التوصيل',
                                  style: TextStyles.textStyle14.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.kASDCPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  '\$0.00',
                                  style: TextStyles.textStyle14.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'رسوم الخدمة',
                                  style: TextStyles.textStyle14.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.kASDCPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
