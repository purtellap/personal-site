import 'package:flutter/material.dart';
import 'package:ps/res/res.dart';
import 'package:ps/util/url.dart';

class Paper extends StatelessWidget {
  final Size cts;
  final AnimationController controller;
  final Image img;
  const Paper(
      {Key? key,
      required this.cts,
      required this.controller,
      required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = Dimens.sceneWidth / Dimens.sceneHeight;
    double top = cts.height;
    double widthS = cts.width;
    double heightS = widthS / ratio;
    double left = widthS / 14;

    if (cts.width < Dimens.mobileView) {
      widthS = cts.width * 2;
      heightS = widthS / ratio;
      left = 24;
      if (cts.width < Dimens.mobileView2) {
        widthS = cts.width * 3;
        heightS = widthS / ratio;
        left = 24;
      }
      if (cts.height < Dimens.mobileLandscape) {
        top = cts.height + heightS / 4.2;
      }
    }

    double size = widthS / 32;

    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromSize(Rect.fromLTWH(0, top, size, size), cts),
        end: RelativeRect.fromSize(
            Rect.fromLTWH(left, top - heightS / 1.8, size, size), cts),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      child: FittedBox(
        child: GestureDetector(
          onTap: () => LaunchURL.of(Strings.resumeLink),
          child: MouseRegion(cursor: SystemMouseCursors.click, child: img),
        ),
        fit: BoxFit.fill,
      ),
    );
  }
}
