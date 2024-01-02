import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/responsive/dimensions.dart';
import 'package:musicplayer/utils/tab.dart';

class MobileLayoutScreen extends StatelessWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarouselController pageViewCarouselController = CarouselController();
    CarouselController tabBarCarouselController = CarouselController();
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final double mWidth =
        DimensionUtil.findDimension(context: context, isHeight: false);
    return Scaffold(
        backgroundColor: colorScheme.background,
        body: CarouselSlider(
          items: tabsContent,
          options: CarouselOptions(
              onPageChanged: (index, reason) {
                tabBarCarouselController.animateToPage(index);
              },
              enlargeFactor: 0.3,
              enlargeCenterPage: true,
              pageSnapping: true,
              enableInfiniteScroll: false,
              height: 50,
              viewportFraction: 0.25),
        ));
  }
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