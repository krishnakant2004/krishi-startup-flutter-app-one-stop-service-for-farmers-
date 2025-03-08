import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../detectionPages/cropdisease.dart';
import '../../detectionPages/preservativepredict.dart';
import '../../utility/app_data.dart';
import '../../widget/carousel_image_viewer.dart';
import '../shop/product_list_screen/product_list_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late CarouselSliderController carouselController = CarouselSliderController();
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size;
    double height, width;

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.8),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "Krishi",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        actions: [Switch(value: true, onChanged: (val) {})],
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _innerBannerSlider(height, width),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Register and Scan Crop",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 18),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      elevation: 7,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 100,
                        width: 160,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage("assets/images/govSheme.png"),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 4, left: 0),
                          child: Text(
                            "Register and\n View gov schemes. ",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PredictPage(),
                          ),
                        );
                      },
                      child: Material(
                        elevation: 7,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 100,
                          width: 160,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage("assets/images/detect.png"),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 4, right: 4, top: 10, bottom: 90),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white.withOpacity(0.9)),
                            child: const Center(
                              child: Text("crop Doctor"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Crop Services",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 18),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.blue, // Border color
                    width: 1.0, // Border width
                  ),
                ),
                child: GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1,
                  ),
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PredictPage(),
                        ),
                      ),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          height: 60,
                          //width: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff00ddff),
                                Color(0xffff00d4),
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Pridic\nDisease",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          )),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CropPredictionForm(),
                        ),
                      ),
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff00ddff),
                              Color(0xffff00d4),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Recommand\nCrop",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Inner Style Indicators Banner Slider
  Widget _innerBannerSlider(double height, double width) {
    return Column(
      children: [
        /// Slider Style
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                "Goverment schemes",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                "See All",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),

        SizedBox(
          height: height * .22,
          width: width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// Carouse lSlider
              Positioned.fill(
                child: CarouselSlider(
                  carouselController: CarouselSliderController(),

                  /// It's options
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                  ),

                  /// Items
                  items: AppData.innerStyleImages.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        /// Custom Image Viewer widget
                        return CustomImageViewer.show(
                          context: context,
                          url: imagePath,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }).toList(),
                ),
              ),

              /// Indicators
              Positioned(
                bottom: height * .02,
                // child: Row(
                //   children: List.generate(
                //     AppData.innerStyleImages.length,
                //     (index) {
                //       bool isSelected = currentPage == index;
                //       return AnimatedContainer(
                //         width: isSelected ? 55 : 17,
                //         height: 10,
                //         margin: EdgeInsets.symmetric(
                //             horizontal: isSelected ? 6 : 3),
                //         decoration: BoxDecoration(
                //           color: isSelected
                //               ? Colors.black87.withOpacity(0.6)
                //               : Colors.black.withOpacity(0.5),
                //           borderRadius: BorderRadius.circular(
                //             40,
                //           ),
                //         ),
                //         duration: const Duration(milliseconds: 300),
                //         curve: Curves.ease,
                //       );
                //     },
                //   ),
                // ),
                child: AnimatedSmoothIndicator(
                    activeIndex: currentPage,
                    count: AppData.innerStyleImages.length,
                  axisDirection: Axis.horizontal,
                  effect:const ExpandingDotsEffect(
                    activeDotColor: Colors.green,
                    dotColor: Colors.white54,
                    dotHeight: 12,
                    dotWidth: 24,
                    radius: 12,
                    spacing: 10,
                    strokeWidth: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
