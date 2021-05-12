import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bubble.dart';
import 'themeData.dart';
import 'utils.dart' as utils;

Future<void> main() async {
  var prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  MyApp(this.prefs);
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sort',
      theme: ThemeProvider(prefs).theme,
      home: SortingPage(title: 'Sort'),
    );
  }
}

class SortingPage extends StatefulWidget {
  SortingPage({this.title = 'title'});

  final String title;

  @override
  _SortingPageState createState() => _SortingPageState();
}

class _SortingPageState extends State<SortingPage> {
  List<utils.Item> sortItems = [];
  List<utils.Step> steps = [];
  String message = '';
  int delay = 100;
  bool isSorting = false;

  @override
  void initState() {
    super.initState();
  }

  void _createSortItems({int length = 7}) {
    sortItems.clear();
    steps.clear();
    message = '';
    isSorting = false;

    final rand = Random();
    for (var i = 0; i < length; i++) {
      final tempNum = rand.nextInt(200);
      var tempheight = tempNum + 1.0;
      var tempwidth = MediaQuery.of(context).size.width / (2 * (length + 1));
      final tempItem = utils.Item(
        i,
        tempNum,
        tempheight,
        tempwidth,
        utils.defaultColor,
      );

      sortItems.add(tempItem);
    }
    bubble();
    setState(() {});
  }

  void bubble() {
    steps = bubbleSort(sortItems);
  }

  @override
  Widget build(BuildContext context) {
    if (sortItems.isEmpty) {
      _createSortItems();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: sortItems
                              .map(
                                (e) => Container(
                                  height: e.height,
                                  width: e.width,
                                  color: e.color,
                                  child: Text(e.value.toString()),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(36),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: sortItems
                                .map(
                                  (e) => Container(
                                    margin: const EdgeInsets.all(0.8),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: e.color == utils.defaultColor
                                          ? Colors.white
                                          : e.color,
                                    ),
                                    height: 50,
                                    width: 50,
                                    child: Center(
                                      child: Text(
                                        e.value.toString(),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(message),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Slider(
                          min: 2,
                          max: 40,
                          activeColor: Theme.of(context).accentColor,
                          inactiveColor: Colors.grey,
                          onChanged: (value) {
                            _createSortItems(length: value.floor());
                          },
                          value: sortItems.length.toDouble(),
                        ),
                        Text('${sortItems.length} elements'),
                        Slider(
                          min: 50,
                          max: 700,
                          activeColor: Theme.of(context).accentColor,
                          inactiveColor: Colors.grey,
                          onChanged: (value) {
                            setState(() {
                              delay = value.floor();
                            });
                          },
                          value: delay.toDouble(),
                        ),
                        Text('$delay ms'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const IconButton(
              icon: Icon(
                Icons.fast_rewind,
                size: 30,
              ),
              onPressed: null,
            ),
            const SizedBox(
              width: 24,
            ),
            IconButton(
              icon: !isSorting
                  ? const Icon(
                      Icons.play_arrow,
                      size: 30,
                    )
                  : const Icon(
                      Icons.pause,
                      size: 30,
                    ),
              onPressed: isSorting ? pause : play,
            ),
            const SizedBox(
              width: 24,
            ),
            const IconButton(
              icon: Icon(
                Icons.fast_forward,
                size: 30,
              ),
              onPressed: null,
            ),
            const SizedBox(
              width: 24,
            ),
            IconButton(
              icon: const Icon(
                Icons.restore,
                size: 30,
              ),
              onPressed: _createSortItems,
            ),
          ],
        ),
      ),
    );
  }

  void play() async {
    // print(steps);
    isSorting = true;
    for (var step in steps) {
      await Future<void>.delayed(
        Duration(milliseconds: delay),
      );
      if (!isSorting) {
        break;
      }
      setState(() {
        sortItems = step.list;
        message = step.reason;
      });
    }
  }

  void pause() async {
    print('called stop');
    setState(() {
      isSorting = false;
    });
  }
}
