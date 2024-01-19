import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/home/data/models/cart_items_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cachedNetworkImage/my_cached_nework_Image.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view_model/cart_cubit/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemRow extends StatelessWidget {
  const CartItemRow({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: SizedBox(
            height: 100.h,
            width: double.infinity,
            child: Row(
              children: [
                Column(
                  children: [
                    BlocConsumer<CartCubit, CartState>(
                      listener: (context, state) {
                        if (state is DeleteItemFailuer) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              messageSnackBar(message: state.errMessage));
                        }
                        if (state is DeleteItemSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              messageSnackBar(message: "تم الحذف"));
                        }
                      },
                      builder: (context, state) {
                        if (state is DeleteItemLoading) {
                          cartItem.loading = true;
                        }
                        if (state is DeleteItemSuccess ||
                            state is DeleteItemFailuer) {
                          cartItem.loading = false;
                        }
                        return IconButton(
                            onPressed: () {
                              context.read<CartCubit>().deleteItem(
                                    itemId: cartItem.id!,
                                  );
                            },
                            icon: Icon(
                              Icons.delete_forever_rounded,
                              size: 25.w,
                              color: AppColors.kRed,
                            ));
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        AppDefaultButton(
                          color: AppColors.kLightGrey,
                          width: 27.w,
                          height: 27.w,
                          onPressed: () {},
                          title: '',
                          icon: Icon(
                            Icons.remove,
                            size: 20.w,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            double.parse(cartItem.quantity!).toInt().toString(),
                            style: TextStyles.textStyle16.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        AppDefaultButton(
                          color: AppColors.kLightRed,
                          width: 27.w,
                          height: 27.w,
                          onPressed: () {},
                          title: '',
                          icon: Icon(
                            Icons.add,
                            size: 20.w,
                            color: AppColors.kRed,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          cartItem.product!.productName!,
                          style: TextStyles.textStyle12.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(
                          width: 100.w,
                          child: Text(
                            cartItem.product!.description!,
                            style: TextStyles.textStyle10.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "\$${cartItem.product!.retailPrice}",
                          style: TextStyles.textStyle16.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.kRed,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15.w),
                        child: MyCachedNetworkImage(
                          width: 70.w,
                          height: 60.h,
                          fit: BoxFit.contain,
                          url: cartItem.product!.image!,
                          errorIcon: Icon(
                            Icons.image,
                            size: 25.w,
                            color: AppColors.kASDCPrimaryColor,
                          ),
                          loadingWidth: 10.w,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
        const GeneralDivider(),
      ],
    );
  }
}
