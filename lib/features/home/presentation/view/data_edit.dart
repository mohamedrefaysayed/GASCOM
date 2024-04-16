import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/core/widgets/app_loading_button.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/auth/presentation/view/widgets/text_field_data_builder.dart';
import 'package:dinar_store/features/auth/presentation/view_model/store_data_cubit/store_data_cubit.dart';
import 'package:dinar_store/features/home/data/models/profile_model.dart';
import 'package:dinar_store/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DataEdit extends StatelessWidget {
  const DataEdit({super.key, required this.profile, required this.position});

  final ProfileModel profile;
  final LatLng position;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (_) {
        ProfileCubit.nameController.clear();
        ProfileCubit.markerPosition = null;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 40.h,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  "تعديل البيــــانات",
                  style: TextStyles.textStyle16.copyWith(
                    fontSize: 20.w,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                TextFieldDataBulder(
                  title: 'الأسم',
                  hint: profile.customer!.name!,
                  onChanged: (value) {},
                  controller: ProfileCubit.nameController,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 10.w,
                        spreadRadius: 15.w,
                        color: AppColors.kGrey,
                      )
                    ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.w),
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return GoogleMap(
                            onTap: (position) {
                              context.read<ProfileCubit>().addMarker(position);
                            },
                            mapToolbarEnabled: false,
                            minMaxZoomPreference:
                                const MinMaxZoomPreference(14, 17),
                            markers: {
                              if (ProfileCubit.marker != null)
                                ProfileCubit.marker!,
                            },
                            compassEnabled: false,
                            zoomControlsEnabled: false,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              zoom: 18,
                              target: position,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              context.read<ProfileCubit>().addMarker(position);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocConsumer<StoreDataCubit, StoreDataState>(
                  listener: (context, state) {
                    if (state is UpdateDataFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        messageSnackBar(
                          message:
                              " خطأ أثناء تعديل البيانات ${state.errMessage}",
                        ),
                      );
                    }
                    if (state is UpdateDataSuccess) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        messageSnackBar(
                          message: "تم تعديل البيانات بنجاح",
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdateDataLoading) {
                      return const AppLoadingButton();
                    }
                    return AppDefaultButton(
                      color: AppColors.kASDCPrimaryColor,
                      onPressed: () {
                        if (ProfileCubit.nameController.text.isNotEmpty ||
                            ProfileCubit.markerPosition != null) {
                          context.read<StoreDataCubit>().updateData(
                                name: ProfileCubit.nameController.text.trim(),
                                position: ProfileCubit.markerPosition,
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            messageSnackBar(
                              message: "لم يتم تعديل اى بيانات",
                            ),
                          );
                        }
                      },
                      title: 'حفظ',
                      textStyle: TextStyles.textStyle16.copyWith(
                        fontSize: 16.w,
                        color: AppColors.kWhite,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
