import 'package:flutter/material.dart';

class AppContainerBoxWidget extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;

  const AppContainerBoxWidget({
    Key? key,
    this.child,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 9,
            color: Colors.black12,
          ),
        ],
      ),
      child: child ?? Container(),
    );
  }
}
