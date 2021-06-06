import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils.dart';

double pi = 0, total = 0, insideCircle = 0;
List<List<double>> coordinates = [];

class PiApproximation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Pi Approximation (Monte Carlo Method)',
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
      backgroundColor: Colors.grey[850],
      body: Stack(
        children: <Widget>[
          RepaintBoundary(
            child: CustomPaint(
              painter: BackgroundPainter(),
              willChange: false,
              isComplex: true,
              child: Container(),
            ),
          ),
          MakeDots(),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white,
              width: size.width,
              height: size.height / 8.3,
            ),
          ),
          Align(
            alignment: const Alignment(0, kIsWeb ? 0.7 : 0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Values(),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Pi (approx): ',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                PiValue(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  late double R;
  @override
  void paint(Canvas canvas, Size size) {
    R = size.width / piRadius;

    final brush = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas
      ..drawCircle(
        Offset(size.width / 2, size.height / 2.5),
        R,
        brush,
      )
      ..drawRect(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2.5),
          height: 2 * R,
          width: 2 * R,
        ),
        brush,
      );
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BackgroundPainter oldDelegate) => false;
}

class Values extends StatefulWidget {
  @override
  _ValuesState createState() => _ValuesState();
}

class _ValuesState extends State<Values> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {}));
    return Text(
      '\tDots inside circle (Red): ${insideCircle.toInt()}\n'
      'Total dots (Red + Green): ${total.toInt()}',
      style: const TextStyle(
        fontFamily: 'Ubuntu',
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }
}

class PiValue extends StatefulWidget {
  @override
  _PiValueState createState() => _PiValueState();
}

class _PiValueState extends State<PiValue> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {}));
    return Text(
      '${pi.toStringAsFixed(20)}',
      style: const TextStyle(
        fontFamily: 'Ubuntu',
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }
}

class MakeDots extends StatefulWidget {
  @override
  _MakeDotsState createState() => _MakeDotsState();
}

class _MakeDotsState extends State<MakeDots> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    coordinates.clear();
    total = 0;
    insideCircle = 0;
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
    WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {}));
    return CustomPaint(
      painter: DotPainter(),
      child: Container(),
    );
  }
}

class DotPainter extends CustomPainter {
  var brush = Paint();
  final random = math.Random();
  late double R;

  @override
  void paint(Canvas canvas, Size size) {
    double x, y;
    R = size.width / piRadius;

    for (var i = 0; i < 50; i++) {
      x = -R + 2 * random.nextDouble() * R;
      y = -R + 2 * random.nextDouble() * R;

      coordinates.add([x, y]);
      if (x * x + y * y <= R * R) ++insideCircle;
      ++total;
    }

    coordinates.forEach((coordinate) {
      x = coordinate[0];
      y = coordinate[1];

      (x * x + y * y > R * R)
          ? brush.color = Colors.greenAccent[400]!
          : brush.color = Colors.red;

      canvas.drawCircle(
        Offset(size.width / 2 + x, size.height / 2.5 + y),
        1,
        brush,
      );
    });

    pi = 4 * insideCircle / total;
  }

  @override
  bool shouldRepaint(DotPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(DotPainter oldDelegate) => false;
}
