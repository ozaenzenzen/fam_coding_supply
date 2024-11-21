import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fam_coding_supply/logic/app_color.dart';

class AppTextFieldWidget extends StatefulWidget {
  final String textFieldTitle;
  final String textFieldHintText;
  final int? maxLines;
  final TextEditingController? controller;
  final bool readOnly;
  final bool ignorePointerActive;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final Function(String value)? onSubmitted;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool? filled;
  final Color? fillColor;
  final InputBorder? border;
  final double? radius;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final FocusNode? focusNode;
  final ScrollController? scrollController;
  final List<Widget>? action;
  final Widget? error;

  const AppTextFieldWidget({
    Key? key,
    required this.textFieldTitle,
    required this.textFieldHintText,
    this.controller,
    this.maxLines,
    this.readOnly = false,
    this.ignorePointerActive = false,
    this.keyboardType,
    this.onTap,
    this.onSubmitted,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.filled = true,
    this.fillColor = AppColorCS.shape_3,
    this.border,
    this.radius,
    this.textInputAction,
    this.autofocus = false,
    this.focusNode,
    this.scrollController,
    this.action,
    this.error,
  }) : super(key: key);

  @override
  State<AppTextFieldWidget> createState() => _AppTextFieldWidgetState();
}

class _AppTextFieldWidgetState extends State<AppTextFieldWidget> {
  double? height;

  @override
  void initState() {
    // if (widget.textFieldMaxLines != null) {
    //   height = null;
    // } else {
    //   height = 48.h;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: 16.h),
        widget.action == null
            ? Text(
                // "Email",
                widget.textFieldTitle,
                style: GoogleFonts.inter(
                  color: const Color(0xff331814),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // "Email",
                    widget.textFieldTitle,
                    style: GoogleFonts.inter(
                      color: const Color(0xff331814),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (widget.action != null) ...widget.action!,
                ],
              ),
        SizedBox(height: 4.h),
        SizedBox(
          // height: 48.h,
          height: height,
          child: widget.ignorePointerActive
              ? IgnorePointer(
                  child: TextField(
                    scrollController: widget.scrollController,
                    focusNode: widget.focusNode,
                    autofocus: widget.autofocus,
                    textInputAction: widget.textInputAction,
                    obscureText: widget.obscureText,
                    controller: widget.controller,
                    keyboardType: widget.keyboardType,
                    // maxLines: 5,
                    maxLines: (widget.obscureText) ? 1 : widget.maxLines,
                    // minLines: 1,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      error: widget.error,
                      filled: widget.filled,
                      fillColor: widget.fillColor,
                      suffixIcon: widget.suffixIcon,
                      prefixIcon: widget.prefixIcon,
                      contentPadding: EdgeInsets.all(10.h),
                      // hintText: "jane29@gmail.com",
                      hintText: widget.textFieldHintText,
                      hintStyle: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      border: widget.border ??
                          OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: widget.radius != null ? BorderRadius.circular(widget.radius!) : BorderRadius.circular(10),
                          ),
                    ),
                    onChanged: widget.onChanged,
                    readOnly: widget.readOnly,
                    // onTap: widget.onTap,
                    onTap: () {
                      if (widget.autofocus) {
                        Scrollable.ensureVisible(
                          widget.focusNode?.context ?? context,
                          // context,
                          alignment: 0.5,
                          duration: const Duration(milliseconds: 100),
                        );
                      }
                      widget.onTap?.call();
                    },
                    onSubmitted: widget.onSubmitted,
                  ),
                )
              : TextField(
                  scrollController: widget.scrollController,
                  focusNode: widget.focusNode,
                  autofocus: widget.autofocus,
                  textInputAction: widget.textInputAction,
                  obscureText: widget.obscureText,
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  // maxLines: 5,
                  maxLines: (widget.obscureText) ? 1 : widget.maxLines,
                  // minLines: 1,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    error: widget.error,
                    filled: widget.filled,
                    fillColor: widget.fillColor,
                    suffixIcon: widget.suffixIcon,
                    prefixIcon: widget.prefixIcon,
                    contentPadding: EdgeInsets.all(10.h),
                    // hintText: "jane29@gmail.com",
                    hintText: widget.textFieldHintText,
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    border: widget.border ??
                        OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                          borderRadius: widget.radius != null ? BorderRadius.circular(widget.radius!) : BorderRadius.circular(10),
                        ),
                  ),
                  onChanged: widget.onChanged,
                  readOnly: widget.readOnly,
                  onTap: () {
                    if (widget.autofocus) {
                      Scrollable.ensureVisible(
                        widget.focusNode?.context ?? context,
                        // context,
                        alignment: 0.5,
                        duration: const Duration(milliseconds: 100),
                      );
                    }
                    widget.onTap?.call();
                  },
                  onSubmitted: widget.onSubmitted,
                ),
        ),
      ],
    );
  }
}
