import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicplayer/cubit/home_carousel_controller_cubit.dart';
import 'package:musicplayer/responsive/dimensions.dart';
import 'package:musicplayer/utils/tab_bar_content.dart';
import 'package:musicplayer/widgets/applogo.dart';
import 'package:musicplayer/widgets/bottom_bar_carousal.dart';
import 'package:musicplayer/widgets/custom_app_bar.dart';
import 'package:musicplayer/utils/main_appbar_action.dart';

class MobileLayoutScreen extends StatelessWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeScreenCarouselController homeScreenCarouselController =
        BlocProvider.of<HomeScreenCarouselController>(context);

    HomeAppBarCarouselController homeAppBarCarouselController =
        BlocProvider.of<HomeAppBarCarouselController>(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final mheight =
        DimensionUtil.findDimension(context: context, isHeight: true);
    final mwidth =
        DimensionUtil.findDimension(context: context, isHeight: false);
    return Scaffold(
        backgroundColor: colorScheme.background,
        //body is made as a stack because the appBar must be overlapped by the body
        body: Stack(
          children: [
            SizedBox(
              // height: 180,
              child: Column(
                children: [
                  CustomAppBar(
                    colorScheme: colorScheme,
                    leading: AppLogo(
                      colorScheme: colorScheme,
                    ),
                    actions: mainAppBarActions,
                  ),
                  const MainBottomAppBar()
                ],
              ),
            ),
            Positioned(
                top: 160,
                child: Container(
                  height: mheight,
                  width: mwidth,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                            color: colorScheme.tertiary,
                            offset: const Offset(0, 15),
                            blurRadius: 20,
                            blurStyle: BlurStyle.outer)
                      ]),
                  child: BlocBuilder<HomeScreenCarouselController,
                      CarouselController>(
                    bloc: homeScreenCarouselController,
                    builder: (context, screencarouselController) {
                      return CarouselSlider(
                          carouselController: screencarouselController,
                          items: tabsContent,
                          options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                homeAppBarCarouselController.animateAndChangePage(index);
                              },
                              scrollPhysics:
                                  const RangeMaintainingScrollPhysics(
                                      parent: PageScrollPhysics()),
                              enlargeCenterPage: false,
                              height: mheight,
                              enableInfiniteScroll: false,
                              viewportFraction: 1));
                    },
                  ),
                ))
          ],
        ));
  }
}
