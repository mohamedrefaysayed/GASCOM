import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cachedNetworkImage/my_cached_nework_Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchItemRow extends StatelessWidget {
  const SearchItemRow({
    super.key,
    required this.imag,
    required this.name,
    required this.onTap,
  });

  final String imag;
  final String name;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 250.w,
                    child: Text(
                      name,
                      style: TextStyles.textStyle14,
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.w),
                    child: MyCachedNetworkImage(
                        height: 40.w,
                        width: 40.w,
                        url: imag,
                        errorIcon: const Icon(
                          Icons.image,
                          color: AppColors.kASDCPrimaryColor,
                        ),
                        loadingWidth: 13.w),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.w),
              child: Material(
                color: AppColors.kTransparent,
                child: InkWell(
                  onTap: onTap,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
