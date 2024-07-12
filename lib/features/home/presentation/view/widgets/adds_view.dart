import 'package:carousel_slider/carousel_slider.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cachedNetworkImage/my_cached_nework_Image.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/ads_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view_model/ads_cubit/ads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddsView extends StatefulWidget {
  const AddsView({super.key});

  @override
  State<AddsView> createState() => _AddsViewState();
}

class _AddsViewState extends State<AddsView> {
  int _current = 0;

  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    context.read<AdsCubit>().getAllAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdsCubit, AdsState>(
      builder: (context, state) {
        if (state is AdsSuccess) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                height: 185.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.w),
                ),
                child: CarouselSlider.builder(
                  itemCount: state.adsModel.ads!.length,
                  carouselController: _controller,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15.w),
                      child: MyCachedNetworkImage(
                        width: double.infinity,
                        url: state.adsModel.ads![itemIndex].paths!,
                        errorIcon: Icon(
                          Icons.image,
                          size: 100.w,
                          color: AppColors.kASDCPrimaryColor,
                        ),
                        loadingWidth: 30.w,
                      ),
                    );
                  },
                  options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.95,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.2,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
              ),
              Positioned.fill(
                bottom: 0.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            state.adsModel.ads!.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: 7.5.w,
                              height: 7.5.w,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return const AdsPlaceHolder();
      },
    );
  }
}
