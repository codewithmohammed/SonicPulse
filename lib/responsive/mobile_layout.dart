import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';

class MobileLayoutScreen extends StatelessWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: colorScheme.primary,
        appBar: AppBar(
            backgroundColor: colorScheme.background,
            leadingWidth: 200,
            leading: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/SONIC.svg',
                  height: 15,
                  colorFilter:
                      ColorFilter.mode(colorScheme.secondary, BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Pulse',
                  style: GoogleFonts.kolkerBrush(
                      textStyle: const TextStyle(fontSize: 28)),
                ),
              ],
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
          bottom: CustomAppBar(),
          ),
        body: SafeArea(
            child: Stack(children: [
          
          Container(child: Container(),)
        ],
        
        
        ),
        
        
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
    return Container(
      color: colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
child:
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         SvgPicture.asset(
            //           'assets/images/SONIC.svg',
            //           height: 20,
            //           colorFilter: ColorFilter.mode(
            //               colorScheme.secondary, BlendMode.srcIn),
            //         ),
            //         const SizedBox(
            //           width: 5,
            //         ),
            //         Text(
            //           'Pulse',
            //           style: GoogleFonts.kolkerBrush(
            //               textStyle: const TextStyle(fontSize: 35)),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         IconButton(
            //             tooltip: 'Search',
            //             onPressed: () {},
            //             icon: const Icon(
            //               Icons.search,
            //               semanticLabel: 'Search',
            //             )),
            //         IconButton(
            //             tooltip: 'More Option',
            //             onPressed: () {},
            //             icon: const Icon(
            //               Icons.more_vert,
            //               semanticLabel: 'More Option',
            //             )),
            //       ],
            //     )
            //   ],
            // ),
            CarouselSlider(
                items: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Spotify",
                        style: TextStyle(
                            fontSize: 18, color: colorScheme.secondary),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Spotify",
                        style: TextStyle(
                          fontSize: 18,
                          color: colorScheme.secondary,
                        ),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Spotify",
                        style: TextStyle(
                            fontSize: 18, color: colorScheme.secondary),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Spotify",
                        style: TextStyle(
                            fontSize: 18, color: colorScheme.secondary),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Spotify",
                        style: TextStyle(
                            fontSize: 18, color: colorScheme.secondary),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Spotify",
                        style: TextStyle(
                            fontSize: 18, color: colorScheme.secondary),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Spotify",
                        style: TextStyle(
                            fontSize: 18, color: colorScheme.secondary),
                      )),
                ],
                options: CarouselOptions(
                    padEnds: true,
                    height: 30,
                    pageSnapping: true,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    viewportFraction: 0.26,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom))

      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 30);
}

// DefaultTabController(
//       length: 7,
//       child: Scaffold(
//         backgroundColor: colorScheme.background,
//         appBar: AppBar(
//           backgroundColor: colorScheme.background,
//           leading: Row(
//             children: [
//               const SizedBox(
//                 width: 10,
//               ),
//               SvgPicture.asset(sonicSvg,
//                   height: 13,
//                   colorFilter:
//                       ColorFilter.mode(colorScheme.secondary, BlendMode.srcIn)),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text('Pulse',
//                   style: GoogleFonts.kolkerBrush(
//                       fontSize: 30, color: colorScheme.secondary))
//             ],
//           ),
//           leadingWidth: mWidth * 0.5,
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.search,
//                 color: colorScheme.secondary,
//               ),
//               tooltip: 'Search',
//               mouseCursor: MaterialStateMouseCursor.clickable,
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.more_vert,
//                 color: colorScheme.secondary,
//               ),
//               tooltip: 'More Options',
//               mouseCursor: MaterialStateMouseCursor.clickable,
//             ),
//           ],
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(50),
//             child: GestureDetector(
//               dragStartBehavior: DragStartBehavior.start,
//               child: TabBar(
//                 tabAlignment: TabAlignment.start,
//                 isScrollable: true,
//                 tabs: tabs,
//                 padding:  EdgeInsets.only(left: mWidth * 0.4, right: mWidth * 0.4),
//               ),
//             ),
//           ),
//         ),
//         body: TabBarView(children: tabsContent),
//       ),
//     );