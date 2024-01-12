import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralDivider extends StatelessWidget {
  const GeneralDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        height: 10.h,
        width: double.infinity,
        color: const Color(0xffF8F9FD),
      ),
    );
  }
}
