import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/auth/presentation/view_model/location_cubit/cubit/location_cubit.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/columns/current_location_column.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/map_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/profile_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileContainer extends StatefulWidget {
  const ProfileContainer({super.key});

  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
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
      child: Column(
        children: [
          BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileSuccess) {
                String location = state.profileModel.customer!.location!;
                List<String> latLng = location.split(",");
                double latitude = double.parse(latLng[0]);
                double longitude = double.parse(latLng[1]);
                context.read<LocationCubit>().getAddress(latitude, longitude);
                print(latitude);
                print(longitude);
              }
            },
            builder: (context, state) {
              if (state is ProfileSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "الاسم: ${state.profileModel.customer!.name}",
                      style: TextStyles.textStyle16.copyWith(
                        fontSize: 16.w,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "${state.profileModel.customer!.mobNo!} : رقم الهاتف",
                      style: TextStyles.textStyle18,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "عدد الطلبات : ${state.profileModel.customer!.noOrders ?? 0}",
                      style: TextStyles.textStyle16.copyWith(
                        fontSize: 16.w,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "العنوان : ${LocationCubit.address}",
                      style: TextStyles.textStyle16.copyWith(
                        fontSize: 16.w,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                );
              }
              return const ProfilePLaceHolder();
            },
          ),
          BlocBuilder<LocationCubit, LocationState>(
            builder: (context, state) {
              if (state is AddressSuccess) {
                return CurrentLocationColumn(
                    currentLocationData: state.locationData);
              }
              return const MapPlaceHolder();
            },
          ),
        ],
      ),
    );
  }
}
