import 'package:flutter/material.dart';

class ProjectItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: AssetImage('assets/btc.png')
        ),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
          ),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SelectableText('Title'),
                SelectableText('Desc'),
              ],
            )
          ),
        ),
      ],
    );
  }
}
