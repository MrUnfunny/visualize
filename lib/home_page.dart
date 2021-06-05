import 'package:flutter/material.dart';
import 'models/algorithm.dart';

import 'models/visual_card.dart';

class HomePage extends StatelessWidget {
  final List<Algorithm> children;

  HomePage(this.children);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth != 0) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: children.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth > 720
                      ? (constraints.maxWidth / 200).floor()
                      : 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                ),
                itemBuilder: (context, index) => VisualCard(
                  algorithm: children[index],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
