import 'package:flutter/material.dart';
import 'package:ps/portfolio/contact.dart';
import 'package:ps/portfolio/projects.dart';
import 'package:ps/portfolio/widgets.dart';
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
      body: SingleChildScrollView(
        child: _LoadingStack(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            constraints: BoxConstraints(
              maxWidth: Dimens.maxPortfolioWidth,
            ),
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
                HeroCard(),
                Dimens.sectionHeight,
                Header(
                  title: Strings.projectsTitle,
                  quote: Strings.projectsQuote,
                ),
                Dimens.subSectionHeight,
                ProjectsWidget(),
                Dimens.sectionHeight,
                Header(
                  title: Strings.designsTitle,
                  quote: Strings.designsQuote,
                ),
                Dimens.subSectionHeight,
                DesignWidget(),
                Dimens.sectionHeight,
                Header(
                  title: Strings.contactTitle,
                  quote: Strings.contactQuote,
                ),
                Dimens.subSectionHeight,
                ContactWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 96,
                  ),
                  child: Footer(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingStack extends StatefulWidget {
  final Widget child;
  _LoadingStack({required this.child});

  @override
  _LoadingStackState createState() => _LoadingStackState();
}

class _LoadingStackState extends State<_LoadingStack> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadImages();
    });
  }

  _loadImages() async {
    for (var image in Images.portfolioImages) {
      await precacheImage(image, context, onError: (exception, stackTrace) {
        print('Failed to load image: $exception');
      });
    }

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
