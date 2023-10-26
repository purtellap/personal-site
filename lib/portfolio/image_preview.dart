import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

import '../res/res.dart';

class ImagePreview extends StatelessWidget {
  final String url;
  const ImagePreview({Key? key, required this.url});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getInfo(url),
      builder: (context, snap) {
        if (snap.hasData) {
          return snap.data as Widget;
        }
        return const SizedBox.shrink();
      },
    );
  }
}

Future<Widget> _getInfo(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final htmlContent = response.body;
      final document = parse(htmlContent);
      final metaTags = document.getElementsByTagName('meta');

      String? imageUrl;
      for (var meta in metaTags) {
        if (meta.attributes['property'] == 'og:image') {
          imageUrl = meta.attributes['content'];
          break;
        } else if (meta.attributes['name'] == 'twitter:image') {
          imageUrl = meta.attributes['content'];
          break;
        }
      }

      if (imageUrl != null) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
              height: 128,
              decoration: BoxDecoration(
                color: ThemeColors.secondaryBackgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.network(imageUrl)),
        );
      }
    }
    // Handle the response here.
  } catch (error) {
    debugPrint(error.toString());
  }
  return SizedBox.shrink();
}
