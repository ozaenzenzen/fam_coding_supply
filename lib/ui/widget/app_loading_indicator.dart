import 'package:fam_coding_supply/logic/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40.h,
      width: 40.h,
      child: const CircularProgressIndicator(
        color: AppColor.primary,
      ),
    );
  }
}
