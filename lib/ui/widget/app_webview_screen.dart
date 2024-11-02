import 'dart:io';

import 'package:fam_coding_supply/logic/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AppWebViewScreen extends StatelessWidget {
  final String title;
  final String linkUrl;

  const AppWebViewScreen({
    key,
    required this.title,
    required this.linkUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: (Platform.isIOS) ? false : true,
      ),
      // android: AndroidInAppWebViewOptions(
      //   useHybridComposition: true,
      // ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  title,
                  textScaleFactor: 1,
                  style: AppTheme.theme.textTheme.displaySmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const Divider(),
            Expanded(
              child: InAppWebView(
                initialOptions: options,
                initialUrlRequest: URLRequest(url: Uri.parse(linkUrl)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
