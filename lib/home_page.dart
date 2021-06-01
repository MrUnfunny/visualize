import 'package:flutter/material.dart';

import 'models/visual_card.dart';
import 'utils.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth != 0) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: sortAlgos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                ),
                itemBuilder: (context, index) => VisualCard(
                  algorithm: sortAlgos[index],
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

class HomeHorizontalList extends StatelessWidget {
  final List<Widget> elements;

  HomeHorizontalList({required this.elements});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: Column(
        children: <Widget>[
          Container(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: elements,
            ),
          ),
        ],
      ),
    );
  }
}
