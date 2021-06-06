import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RayDiagramPainter extends CustomPainter {
  double u = -300.0;
  double v = 0.0;
  double f = 100.0;
  final h = 50.0;
  final Paint _axisPaint = Paint()
    ..color = Colors.grey[700]!
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

  final Paint _pointsPaint = Paint()
    ..color = Colors.grey[700]!
    ..style = PaintingStyle.fill;

  final Paint _objectPaint = Paint()
    ..color = Colors.black87
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0;

  final Paint _imagePaint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0;

  final Paint _rayPaint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  double i = 0;

  RayDiagramPainter(
    this.u,
    this.v,
    this.f,
  ) {
    i = (v / u) * h;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final x0 = size.width / 2;
    final y0 = size.height / 2;
    final width = size.width;

    drawAxes(canvas, size);

    final ux = x0 + u;
    final objectPath = Path()
      ..moveTo(ux, y0)
      ..lineTo(ux, y0 - h)
      ..addOval(Rect.fromCircle(center: Offset(ux, y0 - h), radius: 4));
    canvas.drawPath(objectPath, _objectPaint);

    var span = const TextSpan(
      text: 'O',
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
    );
    var tpo = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )
      ..layout()
      ..paint(canvas, Offset(ux + 2, y0));

    final objectRayPath = Path()
      ..moveTo(ux, y0 - h)
      ..lineTo(x0, y0)
      ..moveTo(ux, y0 - h)
      ..lineTo(x0, y0 - h);
    canvas.drawPath(objectRayPath, _rayPaint);

    final vx = x0 + v;
    final imagePath = Path()
      ..moveTo(vx, y0)
      ..lineTo(vx, y0 - i)
      ..addOval(Rect.fromCircle(center: Offset(vx, y0 - i), radius: 4));
    canvas.drawPath(imagePath, _imagePaint);

    var span1 = const TextSpan(
      text: 'I',
      style: TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    );
    var tpi = TextPainter(
      text: span1,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )
      ..layout()
      ..paint(canvas, Offset(vx + 8, y0));

    final imageRayPath = Path()
      ..moveTo(vx, y0 - i)
      ..lineTo(x0, y0)
      ..moveTo(vx, y0 - i)
      ..lineTo(x0, y0 - h);
    canvas.drawPath(imageRayPath, _rayPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void drawAxes(Canvas canvas, Size size) {
    final x0 = size.width / 2;
    final y0 = size.height / 2;
    final width = size.width;

    final xAxisPath = Path()
      ..reset()
      ..moveTo(0, y0)
      ..lineTo(width, y0);
/*    canvas.drawArc(
      Rect.fromCircle(center: Offset(x0 + (2 * f), y0), radius: (2 * f) + 32),
      pi / 1.22,
      pi / 2.78,
      false,
      _axisPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(x0 - (2 * f), y0), radius: (2 * f) + 32),
      pi + (pi / 1.22),
      (pi / 2.78),
      false,
      _axisPaint,
    );*/
    canvas.drawPath(xAxisPath, _axisPaint);

    xAxisPath
      ..addOval(Rect.fromCircle(center: Offset(x0 - (f), y0), radius: 2))
      ..addOval(Rect.fromCircle(center: Offset(x0 - (2 * f), y0), radius: 2))
      ..addOval(Rect.fromCircle(center: Offset(x0 + (f), y0), radius: 2))
      ..addOval(Rect.fromCircle(center: Offset(x0 + (2 * f), y0), radius: 2));

    canvas.drawPath(xAxisPath, _pointsPaint);

    final yAxisPath = Path()
      ..reset()
      ..moveTo(x0, y0 * 2)
      ..lineTo(x0, 0);
    canvas.drawPath(yAxisPath, _axisPaint);

    var span =
        const TextSpan(text: 'O', style: TextStyle(color: Colors.black54));
    var span1 =
        const TextSpan(text: 'F', style: TextStyle(color: Colors.black54));
    var span2 =
        const TextSpan(text: '2F', style: TextStyle(color: Colors.black54));
    var tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    var tpf = TextPainter(
      text: span1,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    var tp2f = TextPainter(
      text: span2,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    var tpf_1 = TextPainter(
      text: span1,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    var tpf_2 = TextPainter(
      text: span2,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tpf.layout();
    tp2f.layout();
    tpf_1.layout();
    tpf_2.layout();
    tp.paint(canvas, Offset(x0 + 2, y0));
    tpf.paint(canvas, Offset(x0 + 2 - f, y0));
    tp2f.paint(canvas, Offset(x0 + 2 - f - f, y0));
    tpf_1.paint(canvas, Offset(x0 + 2 + f, y0));
    tpf_2.paint(canvas, Offset(x0 + 2 + f + f, y0));
  }
}
