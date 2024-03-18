import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/utils/time_date_handler.dart';
import 'package:dinar_store/features/home/data/models/orders_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/rows/order_product_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WholeOrderView extends StatelessWidget {
  const WholeOrderView({
    super.key,
    required this.order,
  });
  final DinarOrder order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Text(
                  order.status == "1"
                      ? "تم اسنلام الطلب"
                      : order.status == "2"
                          ? "قيد التحضير"
                          : order.status == "3"
                              ? "قيد التوصيل"
                              : order.status == "4"
                                  ? "تم التوصيل"
                                  : order.status == "5"
                                      ? "تم الغاء الطلب"
                                      : "تم الإراجاع",
                  style: TextStyles.textStyle18.copyWith(
                    fontSize: 18.w,
                  ),
                ),
              ),
              const GeneralDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                    itemBuilder: (context, index) => OrderProductRow(
                      order: order,
                      index: index,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
