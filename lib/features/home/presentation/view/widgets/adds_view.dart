import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cachedNetworkImage/my_cached_nework_Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<String> images = [
  'https://vegnews.com/media/W1siZiIsIjQxNDg2L1ZlZ05ld3MuSUhPUEltcG9zc2libGVCdXJnZXJzLkltcG9zc2libGVGb29kcy5qcGciXSxbInAiLCJjcm9wX3Jlc2l6ZWQiLCIyNjExeDE1NDMrMzg1KzAiLCIxNjAweDk0Nl4iLHsiZm9ybWF0IjoianBnIn1dLFsicCIsIm9wdGltaXplIl1d/VegNews.IHOPImpossibleBurgers.ImpossibleFoods.jpg?sha=6b80538869115398',
  'https://www.nrn.com/sites/nrn.com/files/styles/article_featured_retina/public/Popeyes-Wings-Platform.jpeg?itok=A9Qr5f9s',
  'https://www.nrn.com/sites/nrn.com/files/styles/article_featured_retina/public/KFC_Wraps_Disclaimer.jpeg?itok=oFTg238y',
];

class AddsView extends StatefulWidget {
  const AddsView({super.key});

  @override
  State<AddsView> createState() => _AddsViewState();
}

class _AddsViewState extends State<AddsView> {
  int _current = 0;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          height: 185.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.w),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.161),
                  blurRadius: 6.w,
                  offset: Offset(0, 3.h)),
            ],
          ),
          child: CarouselSlider.builder(
            itemCount: images.length,
            carouselController: _controller,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15.w),
                        child: MyCachedNetworkImage(
                          url: images[itemIndex],
                          errorIcon: Icon(
                            Icons.image,
                            size: 40.w,
                            color: AppColors.kASDCPrimaryColor,
                          ),
                          loadingWidth: 30.w,
                        )),
            options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
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
                  children: images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 10.0,
                        height: 10.0,
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
}
