import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:musicplayer/cubit/home_carousel_controller_cubit.dart';
import 'package:musicplayer/utils/deboncer/debouncer.dart';
import 'package:musicplayer/widgets/carousel_text_button.dart';

class MainBottomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainBottomAppBar(
      {super.key, this.title, this.leading, this.titleWidget});

  final String? title;
  final Widget? leading;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer(delay: const Duration(milliseconds: 50));
    final HomeScreenPageController homeScreenPageController = Get.find();
    final HomeAppBarCarouselController homeAppBarCarouselController = Get.find();
    
    return GetBuilder<HomeAppBarCarouselController>(
      builder: (controller) {
        return CarouselSlider(
          carouselController: controller.carouselController,
          items: [
            CarousalTextButton(
              text: 'Spotify',
              onPressed: () => homeScreenPageController.animateAndChangePage(0),
            ),
            CarousalTextButton(
              text: 'Favourites',
              onPressed: () => homeScreenPageController.animateAndChangePage(1),
            ),
            CarousalTextButton(
              text: 'Playlists',
              onPressed: () => homeScreenPageController.animateAndChangePage(2),
            ),
            CarousalTextButton(
              text: 'Tracks',
              onPressed: () => homeScreenPageController.animateAndChangePage(3),
            ),
            CarousalTextButton(
              text: 'Albums',
              onPressed: () => homeScreenPageController.animateAndChangePage(4),
            ),
            CarousalTextButton(
              text: 'Artists',
              onPressed: () => homeScreenPageController.animateAndChangePage(5),
            ),
            CarousalTextButton(
              text: 'Folders',
              onPressed: () => homeScreenPageController.animateAndChangePage(6),
            ),
          ],
          options: CarouselOptions(
            onScrolled: (value) {
              debouncer.run(() {
                var intValue = value!.ceil();
                if (value == value.ceil()) {
                  homeScreenPageController.jumpAndChangePage(intValue);
                }
              });
            },
            padEnds: true,
            height: 50,
            pageSnapping: true,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            viewportFraction: 0.26,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 0);
}
