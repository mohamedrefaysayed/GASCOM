import 'package:dinar_store/core/animations/right_slide_transition.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/genrall.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/core/widgets/app_loading_button.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/auth/presentation/view/widgets/text_field_data_builder.dart';
import 'package:dinar_store/features/auth/presentation/view_model/location_cubit/cubit/location_cubit.dart';
import 'package:dinar_store/features/home/presentation/view/data_edit.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/columns/current_location_column.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/map_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/profile_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view_model/agent_orders_cubit/agent_order_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileContainer extends StatefulWidget {
  const ProfileContainer({super.key});

  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  String address = "";
  @override
  void initState() {
    context.read<ProfileCubit>().getProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 30.w, right: 10.w, left: 10.w, bottom: 20.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(15.w),
        boxShadow: [
          BoxShadow(
            blurRadius: 10.w,
            spreadRadius: 5.w,
            color: AppColors.kLightGrey,
          ),
        ],
      ),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccess) {
            String location = state.profileModel.customer!.location!;
            List<String> latLng = location.split(",");
            double latitude = double.parse(latLng[0]);
            double longitude = double.parse(latLng[1]);
            context.read<LocationCubit>().getAddress(
                  longitude,
                  latitude,
                );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const ProfilePLaceHolder();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "الاسم: ${ProfileCubit.profileModel!.customer!.name}",
                style: TextStyles.textStyle16.copyWith(
                  fontSize: 16.w,
                ),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "${ProfileCubit.profileModel!.customer!.mobNo!} : رقم الهاتف",
                style: TextStyles.textStyle18,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "عدد الطلبات : ${ProfileCubit.profileModel!.customer!.noOrders ?? 0}",
                style: TextStyles.textStyle16.copyWith(
                  fontSize: 16.w,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  if (state is AddressSuccess) {
                    return Column(
                      children: [
                        Text(
                          "العنوان : ${context.read<LocationCubit>().getAddressValue(currentLocationData: state.locationData)}",
                          style: TextStyles.textStyle16.copyWith(
                            fontSize: 16.w,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CurrentLocationColumn(
                            currentLocationData: state.locationData),
                      ],
                    );
                  }
                  return const MapPlaceHolder();
                },
              ),
              if (!isCustomer)
                Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Text(
                      "السعر : ${ProfileCubit.profileModel!.customer!.price ?? 0}",
                      style: TextStyles.textStyle16.copyWith(
                        fontSize: 16.w,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppDefaultButton(
                      color: AppColors.kASDCPrimaryColor,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              height: 200.h,
                              decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(15.w),
                              ),
                              child: Column(
                                children: [
                                  TextFieldDataBulder(
                                    keyType: TextInputType.number,
                                    title: 'تغيير السعر',
                                    onChanged: (value) {},
                                    controller: ProfileCubit.priceController,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  BlocConsumer<AgentOrderCubit,
                                      AgentOrderState>(
                                    listener: (context, state) {
                                      if (state is ChangePriceSuccess) {
                                        context
                                            .read<ProfileCubit>()
                                            .getProfile();
                                        ProfileCubit.priceController.clear();
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(messageSnackBar(
                                                message:
                                                    'تم تغيير السعر بنجاح'));
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is ChangePriceLoading) {
                                        return const AppLoadingButton();
                                      }
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          AppDefaultButton(
                                            width: 100.w,
                                            color: AppColors.kRed,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            title: 'الغاء',
                                            textStyle:
                                                TextStyles.textStyle16.copyWith(
                                              fontSize: 16.w,
                                              color: AppColors.kWhite,
                                            ),
                                          ),
                                          AppDefaultButton(
                                            width: 100.w,
                                            color: AppColors.kASDCPrimaryColor,
                                            onPressed: () {
                                              if (ProfileCubit.priceController
                                                  .text.isNotEmpty) {
                                                context
                                                    .read<AgentOrderCubit>()
                                                    .changePrice(
                                                      newPrice: ProfileCubit
                                                          .priceController.text
                                                          .trim(),
                                                    );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(messageSnackBar(
                                                        message:
                                                            'أكتب السعر الجديد'));
                                              }
                                            },
                                            title: 'تغيير',
                                            textStyle:
                                                TextStyles.textStyle16.copyWith(
                                              fontSize: 16.w,
                                              color: AppColors.kWhite,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      title: 'تغيير السعر',
                      icon: Icon(
                        Icons.money_off_rounded,
                        color: AppColors.kWhite,
                        size: 20.w,
                      ),
                      textStyle: TextStyles.textStyle16.copyWith(
                        fontSize: 16.w,
                        color: AppColors.kWhite,
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 20.h,
              ),
              AppDefaultButton(
                color: AppColors.kASDCPrimaryColor,
                onPressed: () {
                  String location = ProfileCubit.profileModel!.customer!.location!;
                  List<String> latLng = location.split(",");
                  double latitude = double.parse(latLng[0]);
                  double longitude = double.parse(latLng[1]);

                  Navigator.push(
                    context,
                    RightSlideTransition(
                      page: DataEdit(
                          profile: ProfileCubit.profileModel!,
                          position: LatLng(
                            longitude,
                            latitude,
                          )),
                    ),
                  );
                },
                title: 'تعديل البيانات',
                icon: Icon(
                  Icons.edit,
                  color: AppColors.kWhite,
                  size: 20.w,
                ),
                textStyle: TextStyles.textStyle16.copyWith(
                  fontSize: 16.w,
                  color: AppColors.kWhite,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
