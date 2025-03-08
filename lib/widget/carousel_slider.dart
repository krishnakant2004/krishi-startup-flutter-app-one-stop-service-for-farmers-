import 'package:flutter/material.dart';
import 'package:krishidost/utility/utility_extension.dart';
import 'package:krishidost/widget/custom_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/product.dart';
import '../utility/app_data.dart';

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({
    super.key,
    required this.items,
    this.boxFit = BoxFit.contain,
    this.scale = 3.0,
  });

  final List<Images> items;
  final BoxFit boxFit;
  final double scale;

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  int newIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.32;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: height,
          child: PageView.builder(
            itemCount: widget.items.length,
            onPageChanged: (int currentIndex) {
              newIndex = currentIndex;
              setState(() {});
            },
            itemBuilder: (_, index) {
              return FittedBox(
                fit: BoxFit.cover,
                child: CustomNetworkImage(
                  height: height,
                  width: width,
                  imageUrl: widget.items
                          .safeElementAt(index)
                          ?.url ?? '',
                  fit: widget.boxFit,
                  scale: widget.scale,
                ),
              );
            },
          ),
        ),
        //const SizedBox(height: 10,),
        Container(
          padding: const EdgeInsets.all(4),
          width: MediaQuery.of(context).size.width,
          color: AppData.lightGrey,
          child: Center(
            child: AnimatedSmoothIndicator(
              effect: const ScrollingDotsEffect(
                dotColor: AppData.ExtralightGreen,
                activeDotColor: AppData.lightGreen,
              ),
              count: widget.items.length,
              activeIndex: newIndex,
            ),
          ),
        )
      ],
    );
  }
}
