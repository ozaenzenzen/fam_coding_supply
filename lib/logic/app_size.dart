import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize {
  static appSizeInit(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(411, 869),
      minTextAdapt: true,
    );
  }
}
