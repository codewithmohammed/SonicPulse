import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/responsive/dimensions.dart';
import 'package:musicplayer/utils/tab.dart';
import 'package:svg_flutter/svg.dart';

class MobileLayoutScreen extends StatelessWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final mheight =
        DimensionUtil.findDimension(context: context, isHeight: true);
    final mwidth =
        DimensionUtil.findDimension(context: context, isHeight: false);
    return Scaffold(
        backgroundColor: colorScheme.background,
        body: Stack(
          fit: StackFit.loose,
          children: [
            SizedBox(
              // height: 180,
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: colorScheme.background,
                    leadingWidth: 200,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/SONIC.svg',
                            height: 12,
                            colorFilter: ColorFilter.mode(
                                colorScheme.secondary, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Pulse',
                            style: GoogleFonts.kolkerBrush(
                                textStyle: const TextStyle(fontSize: 25)),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      IconButton(
                          tooltip: 'Search',
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            semanticLabel: 'Search',
                          )),
                      IconButton(
                          tooltip: 'More Option',
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert,
                            semanticLabel: 'More Option',
                          )),
                    ],
                    // bottom: const CustomAppBar(),
                  ),
                  const CustomAppBar()
                ],
              ),
            ),
            Positioned(
              top: 160,
              child: Container(
                height: mheight,
                width: mwidth,
                decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: colorScheme.tertiary,
                          offset: const Offset(0, 13),
                          blurRadius: 20,
                          blurStyle: BlurStyle.outer)
                    ]),

                // child: const Text('hello'),
                // child: TabBarView(children: tabsContent),
              ),
            )
          ],
        ));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, this.title, this.leading, this.titleWidget})
      : super(key: key);

  final String? title;
  final Widget? leading;
  final Widget? titleWidget;
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final mwidth =
        DimensionUtil.findDimension(context: context, isHeight: false);
    double textSize = mwidth * 0.05;
    return CarouselSlider(
        items: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Spotify",
                style: TextStyle(
                    fontSize: textSize, color: colorScheme.secondary),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                "Spotify",
                style: TextStyle(
                  fontSize: textSize,
                  color: colorScheme.secondary,
                ),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                "Spotify",
                style: TextStyle(
                    fontSize: textSize, color: colorScheme.secondary),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                "Spotify",
                style: TextStyle(
                    fontSize: textSize, color: colorScheme.secondary),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                "Spotify",
                style: TextStyle(
                    fontSize: textSize, color: colorScheme.secondary),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                "Spotify",
                style: TextStyle(
                    fontSize: textSize, color: colorScheme.secondary),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                "Spotify",
                style: TextStyle(
                    fontSize: textSize, color: colorScheme.secondary),
              )),
        ],
        options: CarouselOptions(
            padEnds: true,
            height: 50,
            pageSnapping: true,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            viewportFraction: 0.26,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom));
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 0);
}
