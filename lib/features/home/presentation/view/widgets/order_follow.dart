import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/features/auth/presentation/view_model/location_cubit/cubit/location_cubit.dart';
import 'package:dinar_store/features/home/data/models/orders_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cards/agent_follow_order_card.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderFollow extends StatefulWidget {
  const OrderFollow({super.key, required this.order});

  final GascomOrder order;

  @override
  State<OrderFollow> createState() => _OrderFollowState();
}

class _OrderFollowState extends State<OrderFollow> {
  LatLng? position;
  String address = '';

  @override
  void initState() {
    List<String> latLng = widget.order.location!.split(",");
    position = LatLng(double.parse(latLng[0]), double.parse(latLng[1]));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder<String>(
        future: context.read<LocationCubit>().getAddressString(
              position!.longitude,
              position!.latitude,
            ),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
            snapshot.hasData
                ? Column(
                    children: [
                      Container(
                        height: 200.h,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 20.h),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.w,
                              spreadRadius: 15.w,
                              color: AppColors.kGrey,
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14.w),
                          child: GoogleMap(
                            zoomGesturesEnabled: false,
                            scrollGesturesEnabled: false,
                            myLocationButtonEnabled: false,
                            mapToolbarEnabled: false,
                            minMaxZoomPreference:
                                const MinMaxZoomPreference(14, 17),
                            markers: {
                              Marker(
                                markerId: const MarkerId('OrderMrarker'),
                                position: LatLng(
                                  double.parse(
                                      widget.order.location!.split(",")[1]),
                                  double.parse(
                                      widget.order.location!.split(",")[0]),
                                ),
                              )
                            },
                            compassEnabled: false,
                            zoomControlsEnabled: false,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              zoom: 18,
                              target: LatLng(
                                double.parse(
                                    widget.order.location!.split(",")[1]),
                                double.parse(
                                    widget.order.location!.split(",")[0]),
                              ),
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 10.w),
                        child: Wrap(
                          children: [
                            Text(
                              snapshot.data!,
                              style: TextStyles.textStyle14
                                  .copyWith(overflow: TextOverflow.visible),
                            ),
                          ],
                        ),
                      ),
                      const GeneralDivider(),
                      AppDefaultButton(
                        icon: Icon(
                          Icons.location_on,
                          color: AppColors.kWhite,
                          size: 25.w,
                        ),
                        color: AppColors.kASDCPrimaryColor,
                        onPressed: () {
                          String googleUrl =
                              'https://www.google.com/maps/search/?api=1&query=${position!.longitude},${position!.latitude}';
                          launchUrlString(googleUrl);
                        },
                        title: "الأتجاه الى الموقع",
                        textStyle: TextStyles.textStyle16.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.kWhite,
                        ),
                      ),
                      const GeneralDivider(),
                      AgentFollowOrderCard(order: widget.order),
                    ],
                  )
                : const Center(child: CircularProgressIndicator()),
      ),
    ));
  }
}
