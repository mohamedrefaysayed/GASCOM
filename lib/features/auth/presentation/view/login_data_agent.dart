import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/app_images.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/app_default_button.dart';
import 'package:dinar_store/core/widgets/app_loading_button.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/auth/presentation/view/widgets/text_field_data_builder.dart';
import 'package:dinar_store/features/auth/presentation/view_model/location_cubit/cubit/location_cubit.dart';
import 'package:dinar_store/features/auth/presentation/view_model/log_in_cubit/log_in_cubit.dart';
import 'package:dinar_store/features/auth/presentation/view_model/store_data_cubit/store_data_cubit.dart';
import 'package:dinar_store/features/home/presentation/view/bottom_nav_view.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class LoginDataAgent extends StatelessWidget {
  const LoginDataAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          LogInCubit.phoneNumber = null;
          LogInCubit.code = null;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Form(
              key: StoreDataCubit.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: ListView(
                children: [
                  SizedBox(
                    height: 70.h,
                  ),
                  Hero(
                    tag: 'dinar_logo',
                    child: Center(
                      child: Image.asset(
                        AppImages.gascomLogo,
                        height: 100.w,
                        width: 100.w,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  TextFieldDataBulder(
                    controller: StoreDataCubit.nameController,
                    title: 'الاسم',
                    onChanged: (value) {},
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'أدخل الأسم';
                      }
                      return null;
                    },
                  ),
                  TextFieldDataBulder(
                    controller: StoreDataCubit.agentNumberController,
                    title: 'رقم التسجيل',
                    onChanged: (value) {},
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'أدخل رقم التسجيل';
                      }
                      return null;
                    },
                  ),
                  TextFieldDataBulder(
                    keyType: TextInputType.number,
                    controller: StoreDataCubit.priceController,
                    title: 'السعر',
                    onChanged: (value) {},
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'أدخل السعر';
                      }
                      return null;
                    },
                  ),
                  BlocBuilder<LocationCubit, LocationState>(
                    builder: (context, state) {
                      if (state is LocationLoading) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 10.h),
                            child: const AppLoadingButton());
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.w, vertical: 10.h),
                        child: Column(
                          children: [
                            AppDefaultButton(
                              icon: (state is LocationSuccess)
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 25.w,
                                    )
                                  : Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 25.w,
                                    ),
                              textStyle: TextStyles.textStyle16.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.w,
                              ),
                              onPressed: () async {
                                await context
                                    .read<LocationCubit>()
                                    .getCurrentLocation(context: context);
                              },
                              title: 'تحديد موقعي',
                              color: AppColors.kASDCPrimaryColor,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              LocationCubit.address != null
                                  ? LocationCubit.address!.street!
                                  : "",
                              style: TextStyles.textStyle16.copyWith(
                                color: AppColors.kASDCPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.w,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const GeneralDivider(),
                  Center(
                    child: Text(
                      'أختيار صورة',
                      style: TextStyles.textStyle16.copyWith(
                        color: AppColors.kASDCPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.w,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ValueListenableBuilder(
                    valueListenable: StoreDataCubit.img,
                    builder: (context, value, child) => value != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15.w),
                            child: Image.file(
                              value,
                              fit: BoxFit.fill,
                            ),
                          )
                        : const SizedBox(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ValueListenableBuilder(
                    valueListenable: StoreDataCubit.img,
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppDefaultButton(
                          width: 120.w,
                          icon: value != null
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 25.w,
                                )
                              : Icon(
                                  Icons.image,
                                  color: Colors.white,
                                  size: 25.w,
                                ),
                          textStyle: TextStyles.textStyle16.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.w,
                          ),
                          onPressed: () async {
                            await context
                                .read<StoreDataCubit>()
                                .getImage(media: ImageSource.gallery);
                          },
                          title: 'المعرض',
                          color: AppColors.kASDCPrimaryColor,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        AppDefaultButton(
                          width: 120.w,
                          icon: value != null
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 25.w,
                                )
                              : Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 25.w,
                                ),
                          textStyle: TextStyles.textStyle16.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.w,
                          ),
                          onPressed: () async {
                            await context
                                .read<StoreDataCubit>()
                                .getImage(media: ImageSource.camera);
                          },
                          title: 'الكاميرا',
                          color: AppColors.kASDCPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: BlocConsumer<StoreDataCubit, StoreDataState>(
                      listener: (context, state) {
                        if (state is StoreDataSuccess) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, BottomNavBarView.id, (route) => false);
                          ScaffoldMessenger.of(context).showSnackBar(
                              messageSnackBar(
                                  message: "تم الحفظ بنجاح !",
                                  isBottomNavBar: true));
                        }
                        if (state is StoreDataFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              messageSnackBar(message: state.errMessage));
                        }
                      },
                      builder: (context, state) {
                        if (state is StoreDataLoading) {
                          return AppLoadingButton(
                            width: 10.w,
                          );
                        }
                        return AppDefaultButton(
                          textStyle: TextStyles.textStyle16.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.w,
                          ),
                          onPressed: () {
                            if (LocationCubit.currentPosition != null) {
                              if (StoreDataCubit.img.value != null) {
                                if (StoreDataCubit.formKey.currentState!
                                    .validate()) {
                                  context.read<StoreDataCubit>().storeData();
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    messageSnackBar(message: "أختر صورة"));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  messageSnackBar(message: "حدد الموقع"));
                            }
                          },
                          title: 'حفظ',
                          color: AppColors.kASDCPrimaryColor,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
