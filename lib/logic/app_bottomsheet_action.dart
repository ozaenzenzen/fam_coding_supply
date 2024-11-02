import 'package:fam_coding_supply/logic/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBottomSheetAction {
  Future<T?> showBottomSheet<T>({
    required BuildContext context,
    bool isDismissable = true,
    double radius = 0,
    bool withStrip = false,
    Color? color,
    Widget? content,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  }) async {
    // return Get.bottomSheet<T>(
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: color ?? AppColor.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius),
              ),
            ),
            padding: padding,
            child: Column(
              children: <Widget>[
                Container(
                  width: 65,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(2.5)),
                    // color: withStrip ? const Color(0xffe8e8e8) : Colors.transparent,
                    color: withStrip ? const Color(0xffC9CDD4) : Colors.transparent,
                  ),
                ),
                const SizedBox(height: 24),
                content!,
              ],
            ),
          ),
        );
      },
      isDismissible: isDismissable,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  Future<void> showBottomSheetV2({
    required BuildContext context,
    bool isDismissable = true,
    double radius = 0,
    bool withStrip = false,
    String title = 'this title',
    Color? color,
    Color? backgroundColor = Colors.transparent,
    Widget? content,
    bool isScrollControlled = false,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  }) async {
    await showModalBottomSheet(
      backgroundColor: backgroundColor,
      context: context,
      isScrollControlled: isScrollControlled,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: color ?? AppColor.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius),
              ),
            ),
            padding: padding,
            child: Column(
              children: <Widget>[
                Container(
                  width: 65,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(2.5),
                    ),
                    color: withStrip ? const Color(0xffC9CDD4) : Colors.transparent,
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          title,
                          style: GoogleFonts.mukta(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      height: 1.h,
                      color: const Color(0xffE2E2E2),
                    ),
                    SizedBox(height: 16.h),
                    content ?? const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showBottomSheetV3({
    required BuildContext context,
    bool isDismissable = true,
    double radius = 0,
    bool withStrip = false,
    String title = 'this title',
    String? description,
    bool? centerTitle = true,
    Color? color,
    Color? backgroundColor = Colors.transparent,
    Widget? content,
    bool isScrollControlled = false,
    bool? withClose = true,
    Widget? imageTitle,
    bool? withSeparatorTitle = true,
    Size? size,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  }) async {
    await showModalBottomSheet(
      backgroundColor: backgroundColor,
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissable,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            // ignore: deprecated_member_use
            top: MediaQueryData.fromView(WidgetsBinding.instance.window).padding.top,
          ),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: color ?? AppColor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius),
                ),
              ),
              padding: padding,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 65,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(2.5),
                      ),
                      color: withStrip ? const Color(0xffC9CDD4) : Colors.transparent,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      imageTitle == null
                          ? Container()
                          : SizedBox(
                              width: size == null ? MediaQuery.of(context).size.width : size.width,
                              child: Center(
                                child: imageTitle,
                              ),
                            ),
                      withClose!
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  title,
                                  style: GoogleFonts.mukta(
                                    color: const Color(0xff1D2129),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              width: size == null ? MediaQuery.of(context).size.width : size.width,
                              alignment: centerTitle! ? Alignment.center : Alignment.centerLeft,
                              child: Text(
                                title,
                                textAlign: centerTitle ? TextAlign.center : TextAlign.left,
                                style: GoogleFonts.mukta(
                                  color: const Color(0xff1D2129),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                      description == null
                          ? Container()
                          : Column(
                              children: <Widget>[
                                Container(
                                  width: size == null ? MediaQuery.of(context).size.width : size.width,
                                  alignment: centerTitle! ? Alignment.center : Alignment.centerLeft,
                                  child: Text(
                                    description,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.mukta(
                                      color: const Color(0xFF616E7C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.h),
                              ],
                            ),
                      withSeparatorTitle!
                          ? Column(
                              children: <Widget>[
                                SizedBox(height: 16.h),
                                Container(
                                  height: 1.h,
                                  color: const Color(0xffE2E2E2),
                                ),
                                SizedBox(height: 16.h),
                              ],
                            )
                          : Container(),
                      content ?? const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
