import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationMap extends StatelessWidget {
  const CurrentLocationMap({
    super.key,
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: 300.w,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.w),
        child: GoogleMap(
          markers: {
            Marker(
              markerId: const MarkerId('موقعك'),
              position: LatLng(lat, lng),
            )
          },
          myLocationEnabled: true,
          liteModeEnabled: true,
          compassEnabled: false,
          zoomGesturesEnabled: false,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            zoom: 18,
            target: LatLng(
              lat,
              lng,
            ),
          ),
        ),
      ),
    );
  }
}
