import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ps/portfolio/astronaut.dart';
import 'package:ps/portfolio/stars.dart';
import 'package:ps/res/res.dart';
import 'package:ps/util/routes.dart';
import 'package:ps/util/url.dart';
import 'package:ps/portfolio/icon_button.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LoadingStack(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Dimens.maxPortfolioWidth,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      PortfolioIconButton(
                        icon: Icons.home_rounded,
                        onPressed: () => Routes.go(context, Routes.home),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                          child: SelectableText(Strings.portfolioTitle,
                              style: TextStyles.portfolio)),
                      PortfolioIconButton(
                        icon: Icons.description_rounded,
                        onPressed: () => LaunchURL.of(Strings.resumeLink),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Hero(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Hero extends StatelessWidget {
  const Hero({Key? key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, cts) {
      final width = max(cts.biggest.width, Dimens.maxPortfolioWidth);
      final height = width / 2.5;
      return Stack(
        alignment: Alignment.centerLeft,
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
          Astronaut(),
        ],
      );
    });
  }
}

class LoadingStack extends StatefulWidget {
  final Widget child;
  LoadingStack({required this.child});

  @override
  _LoadingStackState createState() => _LoadingStackState();
}

class _LoadingStackState extends State<LoadingStack> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadImages();
    });
  }

  _loadImages() async {
    await precacheImage(AssetImage('images/astronaut.png'), context,
        onError: (exception, stackTrace) {
      print('Failed to load image: $exception');
    });

    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(seconds: 2),
      opacity: isLoaded ? 1 : 0,
      child: Align(
        child: widget.child,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
