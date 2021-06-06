import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Function listEq = const DeepCollectionEquality().equals;

class Toothpick {
  bool alignment;
  var end1 = List.filled(2, 0, growable: false);
  var end2 = List.filled(2, 0, growable: false);
  var center = List.filled(2, 0, growable: false);
  Toothpick(this.center, this.alignment) {
    if (alignment == true) {
      end1[0] = center[0];
      end1[1] = center[1] - 20;
      end2[0] = center[0];
      end2[1] = center[1] + 20;
    } else {
      end1[0] = center[0] - 20;
      end1[1] = center[1];
      end2[0] = center[0] + 20;
      end2[1] = center[1];
    }
  }

  bool compareEnd1(List<Toothpick> otherPicks) {
    var flag = 0;
    otherPicks.forEach((pick) {
      if (!listEquals(pick.center, center)) {
        if (listEquals(pick.end1, end1) |
            listEquals(pick.end2, end1) |
            listEquals(pick.center, end1)) {
          flag = 1;
        }
      }
    });
    if (flag == 1) {
      return false;
    } else {
      return true;
    }
  }

  bool compareEnd2(List<Toothpick> otherPicks) {
    int flag = 0;
    otherPicks.forEach((pick) {
      if (!listEquals(pick.center, center)) {
        if (listEquals(pick.end1, end2) |
            listEquals(pick.end2, end2) |
            listEquals(pick.center, end2)) {
          flag = 1;
        }
      }
    });
    if (flag == 1) {
      return false;
    } else {
      return true;
    }
  }
}

class ToothpickPattern extends StatefulWidget {
  @override
  _ToothpickPatternState createState() => _ToothpickPatternState();
}

class _ToothpickPatternState extends State<ToothpickPattern> {
  int step = 0;
  var activeToothPicks = <Toothpick>[];
  var prevToothPicks = <List<Toothpick>>[];
  var toothPicks = <Toothpick>[];
  bool extra = false;
  double _scaleAmount = 1.0;

  void addStep() {
    setState(() {
      step++;
      prevToothPicks.add([]..addAll(activeToothPicks));
      toothPicks += prevToothPicks[prevToothPicks.length - 1];
      activeToothPicks.clear();
      prevToothPicks[prevToothPicks.length - 1].forEach((pick) {
        extra = pick.compareEnd1(toothPicks);
        if (extra) {
          activeToothPicks += [Toothpick(pick.end1, !pick.alignment)];
        }
        extra = pick.compareEnd2(toothPicks);
        if (extra) {
          activeToothPicks += [Toothpick(pick.end2, !pick.alignment)];
        }
      });
    });
  }

  void subtract() {
    if (step == 0) {
      return;
    }
    setState(() {
      step--;
      activeToothPicks.clear();
      activeToothPicks += prevToothPicks[prevToothPicks.length - 1];
      for (int i = 0;
          i < prevToothPicks[prevToothPicks.length - 1].length;
          i++) {
        toothPicks.removeLast();
      }
      prevToothPicks.removeLast();
    });
  }

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
    if (step == 1) {
      activeToothPicks.add(Toothpick([
        (MediaQuery.of(context).size.width / 2).roundToDouble().toInt(),
        (MediaQuery.of(context).size.height / 2 - 100).roundToDouble().toInt()
      ], true));
    }
    return LayoutBuilder(
      // ignore: missing_return
      builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth != 0) {
          ScreenUtil.init(
            constraints,
            designSize: Size(512.0, 1024.0),
          );
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "Toothpick Pattern",
                style: Theme.of(context).textTheme.headline6,
              ),
              centerTitle: true,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: null,
              elevation: 10,
              label: Text(
                'Step: $step',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
            ),
            bottomNavigationBar: Material(
              elevation: 30,
              child: Container(
                height: ScreenUtil().setHeight(1024 / 9),
                color: Theme.of(context).primaryColor,
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            subtract();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            addStep();
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.zoom_out),
                          onPressed: () {
                            setState(() {
                              _scaleAmount -=
                                  _scaleAmount - 0.1 <= 0.01 ? 0 : 0.1;
                            });
                          },
                        ),
                        Expanded(
                          child: Slider(
                            value: _scaleAmount,
                            activeColor: Colors.red,
                            min: 0.01,
                            max: 2,
                            inactiveColor: Colors.grey,
                            onChanged: (value) {
                              setState(() {
                                _scaleAmount = value;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.zoom_in),
                          onPressed: () {
                            setState(() {
                              _scaleAmount += _scaleAmount + 0.1 > 2 ? 0 : 0.1;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: Container(
              child: Transform.scale(
                scale: _scaleAmount,
                child: CustomPaint(
                  painter: ToothpickPainter(
                    activeToothPicks,
                    toothPicks,
                    Theme.of(context).accentColor,
                  ),
                  child: Container(),
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

class ToothpickPainter extends CustomPainter {
  var activeToothpicks = <Toothpick>[];
  var toothpicks = <Toothpick>[];
  var colorTheme = Color(0);
  ToothpickPainter(this.activeToothpicks, this.toothpicks, this.colorTheme);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.strokeWidth = 2;
    paint.color = colorTheme;
    for (int i = 0; i < toothpicks.length; i++) {
      canvas.drawLine(
          Offset(toothpicks[i].end1[0].toDouble(),
              toothpicks[i].end1[1].toDouble()),
          Offset(toothpicks[i].end2[0].toDouble(),
              toothpicks[i].end2[1].toDouble()),
          paint);
    }
    paint.color = Colors.red;
    for (int i = 0; i < activeToothpicks.length; i++) {
      canvas.drawLine(
          Offset(activeToothpicks[i].end1[0].toDouble(),
              activeToothpicks[i].end1[1].toDouble()),
          Offset(activeToothpicks[i].end2[0].toDouble(),
              activeToothpicks[i].end2[1].toDouble()),
          paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
