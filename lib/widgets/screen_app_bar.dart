import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class ScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ScreenAppBar({
    super.key,
    this.svgImage,
    this.filterName,
    this.actions,
  });

  final String? svgImage;
  final String? filterName;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return svgImage != null
        ? Center(
            child: SvgPicture.asset(
              svgImage!,
              height: 45,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (filterName != null)
                TextButton.icon(
                  label: Text(
                    filterName!,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/filter.svg'),
                ),
              if (actions != null)
                Row(
                  children: [...actions!],
                )
            ],
          );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 25);
}
