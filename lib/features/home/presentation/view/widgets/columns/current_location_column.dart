import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/maps/current_location_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrentLocationColumn extends StatelessWidget {
  const CurrentLocationColumn({
    super.key,
    required this.currentLocationData,
  });

  final Map<String, dynamic> currentLocationData;

  String getAddress() {
    List<String> components = [
      currentLocationData['address'].name ?? '',
      currentLocationData['address'].thoroughfare ?? '',
      currentLocationData['address'].locality ?? '',
      currentLocationData['address'].administrativeArea ?? '',
      currentLocationData['address'].country ?? '',
    ];

    // Filter out empty strings and join with commas
    String address =
        components.where((component) => component.isNotEmpty).join(', ');
    return address;
  }

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
            getAddress(),
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
