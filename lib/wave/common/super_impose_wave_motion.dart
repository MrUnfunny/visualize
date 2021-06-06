import 'package:flutter/material.dart';
import '/wave/common/super_impose_wave_painter.dart';
import '/wave/common/wave_equation.dart';
import '/wave/common/wave_title.dart';
import '/wave/model/super_impose_waves.dart';

class SuperImposeWaveMotion extends StatefulWidget {
  final SuperImposeWaves model;
  final double time;

  SuperImposeWaveMotion(
    this.model,
    this.time,
  );

  @override
  _SuperImposeWaveMotionState createState() => _SuperImposeWaveMotionState();
}

class _SuperImposeWaveMotionState extends State<SuperImposeWaveMotion>
    with SingleTickerProviderStateMixin {
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
          Text(
            '${widget.model.title}',
            textAlign: TextAlign.start,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          if (widget.model.description != '')
            Text(
              '${widget.model.description}',
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 13,
              ),
              softWrap: true,
            ),
          const SizedBox(
            height: 8,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (final wave in widget.model.list!) WaveTitle(wave),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CustomPaint(
                painter: SuperImposeWavePainter(
                    widget.model.list!, widget.time, Colors.green),
                child: Container(
                  height: (widget.model.list![0].amplitude * 5) + 64,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (final wave in widget.model.list!) WaveEquation(wave),
            ],
          ),
        ],
      ),
    );
  }
}
