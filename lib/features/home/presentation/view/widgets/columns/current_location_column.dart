import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/auth/presentation/view_model/location_cubit/cubit/location_cubit.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/maps/current_location_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrentLocationColumn extends StatelessWidget {
  const CurrentLocationColumn({
    super.key,
    required this.currentLocationData,
  });

  final Map<String, dynamic> currentLocationData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20.h),
        CurrentLocationMap(
          lat: currentLocationData['lat'],
          lng: currentLocationData['lng'],
        ),
        SizedBox(height: 15.h),
        SizedBox(
          width: 250.w,
          child: Text(
            context
                .read<LocationCubit>()
                .getAddressValue(currentLocationData: currentLocationData),
            style: TextStyles.textStyle12.copyWith(
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
