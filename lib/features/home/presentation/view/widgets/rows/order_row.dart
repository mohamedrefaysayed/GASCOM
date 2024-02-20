import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/utils/time_date_handler.dart';
import 'package:dinar_store/features/home/data/models/orders_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cachedNetworkImage/my_cached_nework_Image.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderRow extends StatelessWidget {
  const OrderRow({super.key, required this.order});

  final DinarOrder order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: Text(
              order.status == "0"
                  ? "تم اسنلام الطلب"
                  : order.status == "1"
                      ? "قيد التحضير"
                      : "قيد التوصيل",
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 15.w,
                      color: AppColors.kASDCPrimaryColor,
                    ),
                  ],
                ),
                Text(
                  "x${order.orderDetails!.length}",
                  style: TextStyles.textStyle16.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.w,
                  ),
                ),
                Text(
                  MyTimeDate.getLastMessageTime(
                      context: context,
                      time: DateTime.parse(order.orderDate!)
                          .millisecondsSinceEpoch
                          .toString()),
                  style: TextStyles.textStyle18
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${order.address!.country!}/${order.address!.city!}/${order.address!.street!}/${order.address!.building!}",
                  style:
                      TextStyles.textStyle14.copyWith(color: AppColors.kGrey),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: order.orderDetails!.length,
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyCachedNetworkImage(
                            height: 30.w,
                            width: 30.w,
                            url: order.orderDetails![index].products!.image!,
                            errorIcon: const Icon(
                              Icons.image,
                              color: AppColors.kASDCPrimaryColor,
                            ),
                            loadingWidth: 10.w,
                          ),
                          Text(
                            "${index + 1} - ${order.orderDetails![index].products!.productName}",
                            textDirection: TextDirection.rtl,
                            style: TextStyles.textStyle14,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const GeneralDivider(),
        ],
      ),
    );
  }
}
