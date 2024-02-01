import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicplayer/cubit/home_carousel_controller_cubit.dart';
import 'package:musicplayer/widgets/carousel_text_button.dart';

class MainBottomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainBottomAppBar({Key? key, this.title, this.leading, this.titleWidget})
      : super(key: key);

  final String? title;
  final Widget? leading;
  final Widget? titleWidget;
  @override
  Widget build(BuildContext context) {
    HomeScreenCarouselController homeScreenCarouselController =
        BlocProvider.of<HomeScreenCarouselController>(context);
    HomeAppBarCarouselController homeAppBarCarouselController =
        BlocProvider.of<HomeAppBarCarouselController>(context);
    return BlocBuilder<HomeAppBarCarouselController, CarouselController>(
      bloc: homeAppBarCarouselController,
      builder: (context, appBarCarouselController) {
        return CarouselSlider(
            carouselController: appBarCarouselController,
            items: [
              CarousalTextButton(
                text: 'Spotify',
                onPressed: () =>
                    homeScreenCarouselController.animateAndChangePage(0),
              ),
              CarousalTextButton(
                text: 'Favourites',
                onPressed: () =>
                    homeScreenCarouselController.animateAndChangePage(1),
              ),
              CarousalTextButton(
                text: 'Playlists',
                onPressed: () =>
                    homeScreenCarouselController.animateAndChangePage(2),
              ),
              CarousalTextButton(
                text: 'Tracks',
                onPressed: () =>
                    homeScreenCarouselController.animateAndChangePage(3),
              ),
              CarousalTextButton(
                text: 'Albums',
                onPressed: () =>
                    homeScreenCarouselController.animateAndChangePage(4),
              ),
              CarousalTextButton(
                text: 'Artists',
                onPressed: () =>
                    homeScreenCarouselController.animateAndChangePage(5),
              ),
              CarousalTextButton(
                text: 'Folders',
                onPressed: () =>
                    homeScreenCarouselController.animateAndChangePage(6),
              ),
            ],
            options: CarouselOptions(
                // onScrolled: (value) {

                //   homeScreenCarouselController.animateAndChangePage();
                // },
                onPageChanged: (index, reason) {
                  homeAppBarCarouselController.animateAndChangePage(index);
                  homeScreenCarouselController.animateAndChangePage(index);
                },
                padEnds: true,
                height: 50,
                pageSnapping: true,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                viewportFraction: 0.26,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom));
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 0);
}
