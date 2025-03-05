import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBottomSheetUtilsCS {
  TextStyle mainTextStyle = GoogleFonts.lato(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xff1A1C1E),
  );

  void tests() {
    mainTextStyle.copyWith();
  }

  showGeneralDraggableBottomSheet(
    BuildContext context, {
    bool useSafeArea = true,
    bool isScrollControlled = true,
    double initialChildSize = 1,
    double maxChildSize = 1,
    double minChildSize = 0.32,
    DraggableScrollableController? draggableScrollableController,
    // Widget? child,
    Widget Function(BuildContext, ScrollController)? builder,
  }) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          maxChildSize: maxChildSize,
          minChildSize: minChildSize,
          expand: false,
          controller: draggableScrollableController,
          builder: builder ??
              (BuildContext context, ScrollController scrollController) {
                return Container();
              },
          // : (BuildContext context, ScrollController scrollController) {
          //     return child;
          //   },
        );
      },
    );
  }

  showAppDraggableBottomSheet(
    BuildContext context, {
    bool useSafeArea = true,
    bool isScrollControlled = true,
    double initialChildSize = 1,
    double maxChildSize = 1,
    double minChildSize = 0.32,
    DraggableScrollableController? draggableScrollableController,
    required String title,
    List<Widget>? actions,
    Widget Function(BuildContext context, ScrollController scrollController)? builder,
  }) {
    showGeneralDraggableBottomSheet(
      context,
      useSafeArea: useSafeArea,
      isScrollControlled: isScrollControlled,
      initialChildSize: initialChildSize,
      maxChildSize: maxChildSize,
      minChildSize: minChildSize,
      draggableScrollableController: draggableScrollableController,
      builder: (BuildContext context, ScrollController scrollController) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.h),
            topRight: Radius.circular(12.h),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 3.h),
                      Container(
                        height: 5.h,
                        width: 36.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.5),
                          color: const Color(0xffC6C6C9),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                actions != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              title,
                              style: mainTextStyle.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff1A1C1E),
                              ),
                            ),
                          ),
                          // ...actions,
                          Row(
                            children: actions,
                          ),
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Text(
                          title,
                          style: mainTextStyle.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff1A1C1E),
                          ),
                        ),
                      ),
                SizedBox(height: 16.h),
                Container(
                  height: 2.h,
                  decoration: const BoxDecoration(
                    color: Color(0XFFF1F0F4),
                  ),
                ),
              ],
            ),
            builder == null ? Container() : builder.call(context, scrollController),
          ],
        ),
      ),
    );
  }

  /// This bottom sheet is used when you have some
  /// stack floating process like snackbar over bottomsheet
  Future<void> showAppBottomSheetSpec(
    BuildContext context, {
    bool isScrollControlled = true,
    bool isDismissable = true,
    double? radius,
    bool withStrip = false,
    bool useSafeArea = true,
    required String title,
    bool centerTitle = false,
    Color? color,
    Color? backgroundColor = Colors.transparent,
    Widget? content,
    List<Widget>? actions,
    bool useHeader = true,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    void Function(bool isOpen)? isBottomSheetOpen,
    Color? backgroundColorBottomSheet,
  }) async {
    isBottomSheetOpen?.call(true);
    await showModalBottomSheet(
      backgroundColor: backgroundColor,
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          bottomSheet: Wrap(
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                decoration: BoxDecoration(
                  color: color ?? Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: radius != null ? Radius.circular(radius) : const Radius.circular(0),
                    topRight: radius != null ? Radius.circular(radius) : const Radius.circular(0),
                  ),
                ),
                // padding: padding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: 3.h),
                              Container(
                                height: 5.h,
                                width: 36.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.5),
                                  color: const Color(0xffC6C6C9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        if (useHeader) ...[
                          actions != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                                      child: Text(
                                        title,
                                        style: mainTextStyle.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff1A1C1E),
                                        ),
                                      ),
                                    ),
                                    // ...actions,
                                    Row(
                                      children: actions,
                                    ),
                                  ],
                                )
                              : centerTitle
                                  ? Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                                        child: Text(
                                          title,
                                          textAlign: TextAlign.center,
                                          style: mainTextStyle.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xff1A1C1E),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                                      child: Text(
                                        title,
                                        style: mainTextStyle.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff1A1C1E),
                                        ),
                                      ),
                                    ),
                          SizedBox(height: 16.h),
                          Container(
                            height: 2.h,
                            decoration: const BoxDecoration(
                              color: Color(0XFFF1F0F4),
                            ),
                          ),
                        ],
                      ],
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.9,
                      ),
                      // child: content ?? Container(),
                      child: SingleChildScrollView(
                        child: content ?? Container(),
                      ),
                    ),
                    // SingleChildScrollView(
                    //   child: content ?? Container(),
                    // )
                    // Expanded(
                    //   child: SingleChildScrollView(
                    //     child: content ?? Container(),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    isBottomSheetOpen?.call(false);
  }

  Future<void> showAppBottomSheet(
    BuildContext context, {
    bool isScrollControlled = true,
    bool isDismissable = true,
    double? radius,
    bool withStrip = false,
    bool useSafeArea = true,
    required String title,
    bool centerTitle = false,
    Color? color,
    Color? backgroundColor = Colors.transparent,
    Widget? content,
    List<Widget>? actions,
    bool useHeader = true,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    void Function(bool isOpen)? isBottomSheetOpen,
  }) async {
    isBottomSheetOpen?.call(true);
    await showModalBottomSheet(
      backgroundColor: backgroundColor,
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState1) {
          setState1.call(() {});
          return Wrap(
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                decoration: BoxDecoration(
                  color: color ?? Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: radius != null ? Radius.circular(radius) : const Radius.circular(0),
                    topRight: radius != null ? Radius.circular(radius) : const Radius.circular(0),
                  ),
                ),
                // padding: padding,
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: 3.h),
                              Container(
                                height: 5.h,
                                width: 36.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.5),
                                  color: const Color(0xffC6C6C9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        if (useHeader) ...[
                          actions != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                                      child: Text(
                                        title,
                                        style: mainTextStyle.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff1A1C1E),
                                        ),
                                      ),
                                    ),
                                    // ...actions,
                                    Row(
                                      children: actions,
                                    ),
                                  ],
                                )
                              : centerTitle
                                  ? Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                                        child: Text(
                                          title,
                                          textAlign: TextAlign.center,
                                          style: mainTextStyle.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xff1A1C1E),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                                      child: Text(
                                        title,
                                        style: mainTextStyle.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff1A1C1E),
                                        ),
                                      ),
                                    ),
                          SizedBox(height: 16.h),
                          Container(
                            height: 2.h,
                            decoration: const BoxDecoration(
                              color: Color(0XFFF1F0F4),
                            ),
                          ),
                        ],
                      ],
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.9,
                      ),
                      // child: content ?? Container(),
                      child: SingleChildScrollView(
                        child: content ?? Container(),
                      ),
                    ),
                    // SingleChildScrollView(
                    //   child: content ?? Container(),
                    // )
                    // Expanded(
                    //   child: SingleChildScrollView(
                    //     child: content ?? Container(),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          );
        });
      },
    );
    isBottomSheetOpen?.call(false);
  }

  Future<void> showAppBottomSheetV2(
    BuildContext context, {
    bool isScrollControlled = true,
    bool isDismissable = true,
    double? radius,
    bool withStrip = false,
    bool useSafeArea = true,
    required String title,
    bool centerTitle = false,
    Color? color,
    Color? backgroundColor = Colors.transparent,
    Widget? content,
    Widget? leading,
    List<Widget>? actions,
    bool useHeader = true,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  }) async {
    await showModalBottomSheet(
      backgroundColor: backgroundColor,
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      builder: (BuildContext context) {
        return BottomSheet(
          onClosing: () {
            //
          },
          builder: (context) => StatefulBuilder(builder: (context, setState) {
            return Wrap(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  decoration: BoxDecoration(
                    color: color ?? Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: radius != null ? Radius.circular(radius) : const Radius.circular(0),
                      topRight: radius != null ? Radius.circular(radius) : const Radius.circular(0),
                    ),
                  ),
                  // padding: padding,
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.h),
                          Center(
                            child: Column(
                              children: [
                                SizedBox(height: 3.h),
                                Container(
                                  height: 5.h,
                                  width: 36.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.5),
                                    color: const Color(0xffC6C6C9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          if (useHeader) ...[
                            actions != null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                                        child: Text(
                                          title,
                                          style: mainTextStyle.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xff1A1C1E),
                                          ),
                                        ),
                                      ),
                                      // ...actions,
                                      Row(
                                        children: actions,
                                      ),
                                    ],
                                  )
                                : centerTitle
                                    ? Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                                          child: Text(
                                            title,
                                            textAlign: TextAlign.center,
                                            style: mainTextStyle.copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xff1A1C1E),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                                        child: Text(
                                          title,
                                          style: mainTextStyle.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xff1A1C1E),
                                          ),
                                        ),
                                      ),
                            SizedBox(height: 16.h),
                            Container(
                              height: 2.h,
                              decoration: const BoxDecoration(
                                color: Color(0XFFF1F0F4),
                              ),
                            ),
                          ],
                        ],
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.9,
                        ),
                        // child: content ?? Container(),
                        child: SingleChildScrollView(
                          child: content ?? Container(),
                        ),
                      ),
                      // SingleChildScrollView(
                      //   child: content ?? Container(),
                      // )
                      // Expanded(
                      //   child: SingleChildScrollView(
                      //     child: content ?? Container(),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Future<void> showAppBottomSheetRND(
    BuildContext context, {
    String? text,
  }) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) {
            bool b = false;
            return StatefulBuilder(builder: (BuildContext context, setState) {
              setState.call(() {});
              return Column(
                children: [
                  Switch(
                    onChanged: (bool v) {
                      setState(() => b = v);
                    },
                    value: b,
                  ),
                  Text(text ?? "default"),
                ],
              );
            });
          },
        );
      },
    );
  }

  // Future<void> showAppBottomSheetV2(
  //   BuildContext context, {
  //   bool isScrollControlled = false,
  //   bool isDismissable = true,
  //   double? radius,
  //   bool withStrip = false,
  //   required String title,
  //   Color? color,
  //   Color? backgroundColor = Colors.transparent,
  //   Widget? content,
  //   List<Widget>? actions,
  //   EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  // }) async {
  //   await showModalBottomSheet(
  //     backgroundColor: backgroundColor,
  //     context: context,
  //     isScrollControlled: isScrollControlled,
  //     builder: (BuildContext context) {
  //       return SingleChildScrollView(
  //         padding: EdgeInsets.only(
  //           bottom: MediaQuery.of(context).viewInsets.bottom,
  //         ),
  //         child: Container(
  //           decoration: BoxDecoration(
  //             color: color ?? Colors.white,
  //             borderRadius: BorderRadius.only(
  //               topLeft: radius != null ? Radius.circular(radius) : const Radius.circular(0),
  //               topRight: radius != null ? Radius.circular(radius) : const Radius.circular(0),
  //             ),
  //           ),
  //           // padding: padding,
  //           child: Column(
  //             children: <Widget>[
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(height: 5.h),
  //                   Center(
  //                     child: Column(
  //                       children: [
  //                         SizedBox(height: 3.h),
  //                         Container(
  //                           height: 5.h,
  //                           width: 36.w,
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(2.5),
  //                             color: const Color(0xffC6C6C9),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(height: 16.h),
  //                   actions != null
  //                       ? Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Padding(
  //                               padding: EdgeInsets.symmetric(horizontal: 12.w),
  //                               child: Text(
  //                                 title,
  //                                 style: mainTextStyle.copyWith(
  //                                   fontSize: 16.sp,
  //                                   fontWeight: FontWeight.w700,
  //                                   color: const Color(0xff1A1C1E),
  //                                 ),
  //                               ),
  //                             ),
  //                             // ...actions,
  //                             Row(
  //                               children: actions,
  //                             ),
  //                           ],
  //                         )
  //                       : Padding(
  //                           padding: EdgeInsets.symmetric(horizontal: 12.w),
  //                           child: Text(
  //                             title,
  //                             style: mainTextStyle.copyWith(
  //                               fontSize: 16.sp,
  //                               fontWeight: FontWeight.w700,
  //                               color: const Color(0xff1A1C1E),
  //                             ),
  //                           ),
  //                         ),
  //                   SizedBox(height: 16.h),
  //                   Container(
  //                     height: 2.h,
  //                     decoration: const BoxDecoration(
  //                       color: Color(0XFFF1F0F4),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               content ?? Container(),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
