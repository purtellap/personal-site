import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ps/portfolio/icon_button.dart';
import 'package:ps/portfolio/stars.dart';
import 'package:ps/res/res.dart';

import '../util/url.dart';
import 'astronaut.dart';

class HeroCard extends StatelessWidget {
  const HeroCard();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, cts) {
      final width = max(cts.biggest.width, Dimens.maxPortfolioWidth);
      final height = width / 2.5;
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: ThemeColors.containerGradients,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: PortfolioStars(width: width, height: height),
          ),
          Align(alignment: Alignment.centerLeft, child: Astronaut()),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                DateTime.now().year.toString(),
                style: TextStyles.portfolio.copyWith(
                    fontSize: 48,
                    color: Colors.white.withOpacity(0.3),
                    letterSpacing: 6),
              ),
            ),
          )
        ],
      );
    });
  }
}

class Header extends StatelessWidget {
  final String title;
  final String quote;
  const Header({Key? key, required this.title, required this.quote});

  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyles.portfolio
        .copyWith(fontSize: 54, fontWeight: FontWeight.bold, letterSpacing: 2);
    final descStyle = TextStyles.portfolio
        .copyWith(fontSize: 14, color: ThemeColors.headerDescColor);

    if (context.isMobileWidth) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SelectableText(title, style: headerStyle),
            const SizedBox(width: 32),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SelectableText(
                quote,
                style: descStyle,
                maxLines: 2,
              ),
            ),
          ],
        ),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SelectableText(title, style: headerStyle),
        const SizedBox(width: 32),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SelectableText(
              quote,
              style: descStyle,
              maxLines: 2,
              minLines: 2,
            ),
          ),
        ),
      ],
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final TextStyle? style;

  const GradientText({
    Key? key,
    required this.text,
    required this.onPressed,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = style ?? TextStyles.portfolio.copyWith(fontSize: 20);
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: ThemeColors.textGradients,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: Text(text, style: textStyle, softWrap: true),
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onPressed;
  const StatsCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = ThemeColors.textColor;
    final backgroundColor = ThemeColors.backgroundColor.withOpacity(0.25);
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        highlightColor: Color(0x08ffffff),
        hoverColor: Color(0x08ffffff),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            Icon(icon, size: 20, color: textColor),
            SizedBox(width: 8),
            Text(text,
                style: TextStyles.portfolio
                    .copyWith(fontSize: 14, color: textColor)),
          ]),
        ),
      ),
    );
  }
}

class DesignWidget extends StatelessWidget {
  const DesignWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = 128;
    final double paddedSize = 96;
    final double previewWidth = context.isMobileWidth ? paddedSize : 200;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          Images.figma,
          isAntiAlias: true,
          height: paddedSize,
        ),
        const SizedBox(width: 32),
        Expanded(
          child: OnHover(
            updatePointer: false,
            builder: (isHovered) {
              return Container(
                height: size,
                decoration: BoxDecoration(
                  color: ThemeColors.secondaryBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => LaunchURL.of(Strings.designPortfolioLink),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          width: previewWidth,
                          decoration: BoxDecoration(
                            color: ThemeColors.secondaryBackgroundColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.asset(
                            Images.design,
                            isAntiAlias: true,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText(
                              text: Strings.designName,
                              style:
                                  TextStyles.portfolio.copyWith(fontSize: 24),
                              onPressed: () =>
                                  LaunchURL.of(Strings.designPortfolioLink),
                            ),
                            Flexible(
                              child: SelectableText(
                                Strings.designDescription,
                                style: TextStyles.portfolio.copyWith(
                                    color: ThemeColors.secondaryTextColor,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double padding = 16;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PortfolioIconButton(
          onPressed: () => LaunchURL.of(Strings.email),
          icon: Icons.email,
        ),
        SizedBox(width: padding),
        PortfolioIconButton(
          onPressed: () => LaunchURL.of(Strings.github),
          image: Images.github,
        ),
        SizedBox(width: padding),
        PortfolioIconButton(
          onPressed: () => LaunchURL.of(Strings.linkedin),
          image: Images.linkedin,
        ),
        SizedBox(width: padding),
        PortfolioIconButton(
          onPressed: () => LaunchURL.of(Strings.instagram),
          image: Images.instagram,
        ),
        SizedBox(width: padding),
        PortfolioIconButton(
          onPressed: () => LaunchURL.of(Strings.youtube),
          image: Images.youtube,
        ),
      ],
    );
  }
}

class OnHover extends StatefulWidget {
  final Widget Function(bool isHovered) builder;
  final bool updatePointer;
  final bool translate;

  const OnHover({
    Key? key,
    required this.builder,
    this.updatePointer = true,
    this.translate = true,
  });

  @override
  _OnHoverState createState() => _OnHoverState();
}

class _OnHoverState extends State<OnHover> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hovered = Matrix4.identity()..translate(0, -2, 0);
    final transform = isHovered ? hovered : Matrix4.identity();
    return MouseRegion(
      cursor:
          widget.updatePointer ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => onEntered(true),
      onExit: (_) => onEntered(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        transform: widget.translate ? transform : null,
        child: widget.builder(isHovered),
      ),
    );
  }

  void onEntered(bool isHovered) => setState(() => this.isHovered = isHovered);
}
