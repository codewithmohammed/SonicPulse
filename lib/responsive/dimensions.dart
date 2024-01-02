import 'package:flutter/material.dart';

class DimensionUtil {
  static findDimension({required BuildContext context,required bool isHeight}) {
    return isHeight? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width ;
  }
}
const mobileWidth = 600;