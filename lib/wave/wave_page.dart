import 'dart:math';

import 'package:flutter/material.dart';
import '/wave/common/overlapping_wave_motion.dart';
import '/wave/common/super_impose_wave_motion.dart';
import '/wave/common/wave_motion.dart';
import '/wave/model/overlapping_waves.dart';
import '/wave/model/super_impose_waves.dart';
import '/wave/model/wave.dart';

class WavePage extends StatefulWidget {
  @override
  _WavePageState createState() => _WavePageState();
}

class _WavePageState extends State<WavePage>
    with SingleTickerProviderStateMixin {
  static final _wave1 = Wave(
    title: 'Sinusoidal Wave travelling in forward direction with 0° phase',
    description: '- sign indicates wave moving forward',
    amplitude: 50,
    wavelength: 100,
    frequency: 1000,
    phase: 0,
    color: Colors.red,
  );
  static final _wave1b = Wave(
    title: 'Sinusoidal Wave travelling in forward direction with 180° phase',
    description: 'Notice how change of phase causes wave change',
    amplitude: 50,
    wavelength: 100,
    frequency: 1000,
    phase: pi,
    color: Colors.blue,
  );
  static final _wave1a = Wave(
    title: 'Sinusoidal Wave travelling in backward direction',
    description: '+ sign indicated wave moves backward',
    amplitude: 50,
    wavelength: 100,
    frequency: 1000,
    phase: 0,
    color: Colors.red,
    forward: false,
  );
  static final _wave2 = Wave(
    title: 'Sinusoidal Wave travelling in forward direction',
    description:
        'Notice how decreasing of wavelength but frequency fixed causes wave to slow down\n'
        'Increasing Amplitude causes wave to stretch vertically',
    amplitude: 80,
    wavelength: 70,
    frequency: 1000,
    phase: 0,
    color: Colors.green,
  );
  final list = [_wave1, _wave1b, _wave2, _wave1a];
  final overlap1 = OverlappingWaves(
    list: [_wave1, _wave2],
    title: 'Different wavelength waves',
    description:
        'A better visual representation of two waves with different wavelength, amplitude but same frequency',
  );
  final overlap2 = OverlappingWaves(
    list: [
      _wave1,
      _wave1a
        ..phase = pi
        ..color = Colors.blue
        ..forward = true
    ],
    title: 'Out of phase waves',
    description: 'Same two waves just one of them is 180° out of phase',
  );

  final superImpose1 = SuperImposeWaves(
    list: [
      _wave1.copyWith(color: Colors.grey[500], phase: 0, width: 2),
      _wave1a.copyWith(
          amplitude: 80, color: Colors.black54, phase: 0, width: 2),
    ],
    title: 'Superimposition of waves',
    description:
        'Showing the superimposition of two identical waves with different amplitudes',
  );

  final superImpose2 = SuperImposeWaves(
    list: [
      _wave1.copyWith(color: Colors.grey[500], width: 2),
      _wave1a.copyWith(color: Colors.black54, forward: false, width: 2),
    ],
    title: 'Stationary waves',
    description:
        'Two identical waves travelling in opposite direction give rise to stationary waves. Note these wave do not propogate. See the nodes and antinodes.',
  );
  final superImpose3 = SuperImposeWaves(
    list: [
      _wave1.copyWith(
          color: Colors.grey[500], width: 2, frequency: 1000, wavelength: 108),
      _wave1.copyWith(
          color: Colors.black54, width: 2, frequency: 1080, wavelength: 100),
    ],
    title: 'Beat Frequency in Sound Waves',
    description:
        'Two sound waves travelling in same direction, same amplitudes but different frequencies give rise to phenomenon known as Beats.',
  );
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Physics'),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => Text(
                't = ${_controller.value.toStringAsFixed(0)} sec',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
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
                      'A=Amplitude λ=Wavelength f=Frequency Φ=Phase\n'
                      'y=Asin(kx-wt+Φ)\n'
                      'k=2π/λ  w=2πf',
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
                for (final wave in list)
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) =>
                        WaveMotion(wave, _controller.value),
                  ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) => OverlappingWaveMotion(
                    overlap2,
                    _controller.value,
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) => OverlappingWaveMotion(
                    overlap1,
                    _controller.value,
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) => SuperImposeWaveMotion(
                    superImpose1,
                    _controller.value,
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) => SuperImposeWaveMotion(
                    superImpose2,
                    _controller.value,
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) => SuperImposeWaveMotion(
                    superImpose3,
                    _controller.value,
                  ),
                ),
              ],
            ),
            Positioned(
              right: 12,
              top: 4,
              child: RaisedButton(
                elevation: 1,
                focusElevation: 1,
                highlightElevation: 1,
                hoverElevation: 1,
                onPressed: () {
                  setState(() {
                    if (_controller.isAnimating) {
                      _controller.stop();
                    } else {
                      _controller.repeat();
                    }
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      _controller.isAnimating ? Icons.pause : Icons.play_arrow,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(_controller.isAnimating ? 'PAUSE' : 'PLAY')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
