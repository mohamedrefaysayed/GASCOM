import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddsSlider extends StatefulWidget {
  const AddsSlider({super.key, required this.images});

  final List<String> images;

  @override
  State<AddsSlider> createState() => _AddsSliderState();
}

class _AddsSliderState extends State<AddsSlider> with TickerProviderStateMixin {
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: PageView.builder(
        itemCount: widget.images.length,
        padEnds: false,
        pageSnapping: false,
        physics: const BouncingScrollPhysics(),
        reverse: true,
        controller: PageController(initialPage: 3, viewportFraction: 0.7),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(14.w)),
            child: CachedNetworkImage(imageUrl: widget.images[index]),
          );
        },
      ),
    );
  }
}
