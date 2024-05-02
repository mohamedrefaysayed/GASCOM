import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/app_images.dart';
import 'package:dinar_store/core/utils/constants.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoAnimatedOpacity extends StatefulWidget {
  const LogoAnimatedOpacity({super.key});

  @override
  State<LogoAnimatedOpacity> createState() => _LogoAnimatedOpacityState();
}

class _LogoAnimatedOpacityState extends State<LogoAnimatedOpacity> {
  final ValueNotifier<double> _opacity = ValueNotifier<double>(0);

  @override
  void dispose() {
    _opacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1), () {
        _opacity.value = 1;
      }),
      builder: (context, snapshot) => ValueListenableBuilder(
        valueListenable: _opacity,
        builder: (context, opacity, child) => AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 1500),
          child: Column(
            children: [
              Image.asset(
                AppImages.gascomLogo,
                height: kIsTablet ? 150.h : 150.h,
                width: 150.w,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'Gaznaa',
                style: TextStyles.textStyle24.copyWith(
                  color: AppColors.kASDCPrimaryColor,
                  fontSize: 24.w,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
