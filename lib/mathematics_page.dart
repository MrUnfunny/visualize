import 'package:flutter/material.dart';

class MathematicsPage extends StatelessWidget {
  final List<Widget> children;
  MathematicsPage(this.children);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: (MediaQuery.of(context).size.width < 600)
            ? 2
            : (MediaQuery.of(context).size.width / 200).floor(),
        children: children,
      ),
    );
  }
}
