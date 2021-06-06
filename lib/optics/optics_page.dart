import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/optics/ray_diagram.dart';

class OpticsPage extends StatefulWidget {
  @override
  _OpticsPageState createState() => _OpticsPageState();
}

class _OpticsPageState extends State<OpticsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _controller = AnimationController(
      lowerBound: 0,
      upperBound: 200,
      duration: const Duration(seconds: 200),
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Optics: Convex Lens Ray Diagram'),
        actions: <Widget>[],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
              ),
              children: <Widget>[
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) => const Text(
                      'u = Object Distance v = Image Distance\n'
                      'f = Focal Length of Lens',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ),
                RayDiagram('Object Ray Diagram of Simple Convex Lens'),
                RayDiagram(
                  'Object Ray Diagram of Simple Concave Lens',
                  f: -100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
