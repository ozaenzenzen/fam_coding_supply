import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppCustomAppBarItem {
  AppCustomAppBarItem({
    required this.iconData,
    required this.text,
    this.fontSize = 12,
  });
  IconData iconData;
  String text;
  double fontSize;
}

class AppCustomAppBar extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  AppCustomAppBar({
    required this.items,
    this.centerItemText,
    this.height = 60.0,
    this.iconSize = 24.0,
    this.fontSize = 12.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
    this.currentIndex = 0,
  }) {
    assert(
      items!.length == 2 || items!.length == 4,
    );
  }
  final List<AppCustomAppBarItem>? items;
  final String? centerItemText;
  final double? height;
  final double? iconSize;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape? notchedShape;
  // final ValueChanged<int>? onTabSelected;
  final Function(int)? onTabSelected;
  final int currentIndex;

  @override
  State<StatefulWidget> createState() => AppCustomAppBarState();
}

class AppCustomAppBarState extends State<AppCustomAppBar> {
  int _selectedIndex = 0;

  // ignore: unused_element
  _updateIndex(int index) {
    // widget.onTabSelected!(index);
    widget.onTabSelected!(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = widget.currentIndex;
    List<Widget> items = List.generate(widget.items!.length, (int index) {
      return _buildTabItem(
        item: widget.items![index],
        index: index,
        onPressed: (index) {
          // debugPrint("klik index $index");
          widget.onTabSelected!(index);
          setState(() {
            _selectedIndex = index;
          });
        },
        // fontSize: widget.fontSize!,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      color: widget.backgroundColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: widget.iconSize,
            ),
            Text(
              widget.centerItemText ?? '',
              style: GoogleFonts.inter(
                color: widget.color,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required AppCustomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
    // double fontSize = 12,
  }) {
    Color? color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            borderRadius: BorderRadius.circular(40),
            child: Container(
              decoration: BoxDecoration(
                color: _selectedIndex == index ? Colors.white24 : Colors.transparent,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    item.iconData,
                    color: color,
                    size: widget.iconSize,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    item.text,
                    style: GoogleFonts.inter(
                      color: color,
                      fontSize: item.fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
