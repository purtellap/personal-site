import 'package:flutter/material.dart';
import 'package:ps/portfolio/widgets.dart';
import 'package:ps/util/url.dart';

import '../res/res.dart';

class ProjectWidget extends StatelessWidget {
  final String title;
  final String description;
  final String onPressedUrl;
  final String onStoreUrl;
  final String onGithubUrl;
  final String imageUrl;
  final String? downloads;
  final String? rating;
  final String language;
  final bool cover;

  ProjectWidget({
    required this.title,
    required this.description,
    required this.onPressedUrl,
    required this.onStoreUrl,
    required this.onGithubUrl,
    required this.imageUrl,
    required this.downloads,
    required this.rating,
    required this.language,
    this.cover = false,
  });

  @override
  Widget build(BuildContext context) {
    return OnHover(
      updatePointer: false,
      builder: (isHovered) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: ThemeColors.secondaryBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => LaunchURL.of(onPressedUrl),
                      child: Container(
                        width: 48,
                        height: 48,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: ThemeColors.backgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(cover ? 0 : 12),
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                            isAntiAlias: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GradientText(
                          text: title,
                          onPressed: () => LaunchURL.of(onPressedUrl),
                        ),
                        SelectableText(
                          description,
                          style: TextStyles.portfolio.copyWith(
                              color: Colors.white.withOpacity(0.2),
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                //ImagePreview(url: onPressedUrl),
                SizedBox(height: 8),
                Row(
                  children: [
                    if (downloads != null) ...[
                      StatsCard(
                        icon: Icons.download_rounded,
                        text: downloads!,
                        onPressed: () => LaunchURL.of(onStoreUrl),
                      ),
                      SizedBox(width: 8),
                    ],
                    if (rating != null) ...[
                      StatsCard(
                        icon: Icons.star_rounded,
                        text: rating!,
                        onPressed: () => LaunchURL.of(onStoreUrl),
                      ),
                      SizedBox(width: 8),
                    ],
                    StatsCard(
                      icon: Icons.code_rounded,
                      text: language,
                      onPressed: onGithubUrl != ''
                          ? () => LaunchURL.of(onGithubUrl)
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProjectsWidget extends StatelessWidget {
  List<Widget> _buildProjects(bool? split1) {
    final projects = Projects.projects;
    final List<Widget> list = [];
    for (var i = 0; i < projects.length; i++) {
      if (split1 == null) {
        list.add(projects[i]);
      } else {
        if (split1 && i.isEven) {
          list.add(projects[i]);
        } else if (!split1 && i.isOdd) {
          list.add(projects[i]);
        }
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, cts) {
      if (context.isMobileWidth) {
        return Column(children: [..._buildProjects(null)]);
      } else {
        return Row(
          children: [
            Expanded(
              child: Column(
                children: [..._buildProjects(true)],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [..._buildProjects(false)],
              ),
            )
          ],
        );
      }
    });
  }
}
