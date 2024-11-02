import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fam_coding_supply/logic/app_color.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onBack;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  
  const AppBarWidget({
    Key? key,
    required this.title,
    this.onBack,
    this.actions,
    this.bottom,
  }) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primary,
      elevation: 10,
      shadowColor: const Color(0xff101828),
      centerTitle: true,
      leading: InkWell(
        onTap: widget.onBack ??
            () {
              Get.back();
            },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      title: Text(
        widget.title,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
      ),
      actions: widget.actions,
      bottom: widget.bottom,
    );
  }
}

// class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final Function()? onBack;
//   final List<Widget>? actions;
//   final PreferredSizeWidget? bottom;

//   const AppBarWidget({
//     key,
//     required this.title,
//     this.actions,
//     this.onBack,
//     this.bottom,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: AppColor.primary,
//       elevation: 10,
//       shadowColor: const Color(0xff101828),
//       centerTitle: true,
//       leading: InkWell(
//         onTap: onBack ??
//             () {
//               Get.back();
//             },
//         child: const Icon(
//           Icons.arrow_back,
//           color: Colors.white,
//         ),
//       ),
//       title: Text(
//         title,
//         style: GoogleFonts.inter(
//           color: Colors.white,
//           fontWeight: FontWeight.w600,
//           fontSize: 18.sp,
//         ),
//       ),
//       actions: actions,
//       bottom: bottom,
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
