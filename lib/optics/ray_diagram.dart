import 'package:flutter/material.dart';
import 'ray_diagram_painter.dart';

class RayDiagram extends StatefulWidget {
  final String title;
  final double u;
  final double v;
  final double f;

  RayDiagram(
    this.title, {
    this.u = -200,
    this.v = 0,
    this.f = 100,
  });

  @override
  _RayDiagramState createState() => _RayDiagramState();
}

class _RayDiagramState extends State<RayDiagram>
    with SingleTickerProviderStateMixin {
  double u = -200;
  double v = 0;
  double f = 100;

  @override
  void initState() {
    super.initState();
    u = widget.u.toInt() == 0 ? widget.u : u;
    v = widget.v.toInt() == 0 ? widget.v : v;
    f = widget.f.toInt() == 0 ? widget.f : f;
    v = (u * f) / (u + f);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ),
          Container(
            child: Text(
              'u = ${u.toStringAsFixed(1)}     v = ${v.toStringAsFixed(1)}\n'
              'f = ${f.toStringAsFixed(1)}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          CustomPaint(
            painter: RayDiagramPainter(u, v, f),
            child: Container(
              height: 350,
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Text(
            'Position of Object (u): ${u.toStringAsFixed(1)}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          Slider(
            value: u,
            min: -300,
            max: -10,
            onChanged: onUChanged,
          ),
        ],
      ),
    );
  }

  void onUChanged(double u) {
    setState(() {
      this.u = u;
      v = (u * f) / (u + f);
    });
  }
}
