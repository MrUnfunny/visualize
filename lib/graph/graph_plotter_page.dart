import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '/graph/axes_painter.dart';
import '/graph/graph_painter.dart';
import '/graph/widgets/graph_data_tile.dart';
import 'models/graph.dart';

class GraphPlotterPage extends StatefulWidget {
  @override
  _GraphPlotterPageState createState() => _GraphPlotterPageState();
}

class _GraphPlotterPageState extends State<GraphPlotterPage> {
  double scaleFactor = 35;
  final graphs = <Graph>[];

  @override
  void initState() {
    super.initState();
    graphs.add(
      Graph(
        id: const Uuid().v1(),
        color: Colors.green,
        function: 'x^3',
        isVisible: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Graph Plotter'),
        actions: <Widget>[],
      ),
      body: Container(
        child: kIsWeb
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    width: 300,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          color: Colors.black12,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: <Widget>[
                          ...graphs.map(
                            (e) => Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: GraphDataTile(
                                e,
                                onChange: onChange,
                                key: ValueKey<String>(e.id),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                graphs.add(
                                  Graph(
                                    id: const Uuid().v1(),
                                    color: Colors.blue,
                                    function: 'x^3',
                                    isVisible: true,
                                  ),
                                );
                              });
                            },
                            child: const Text('+ ADD MORE'),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: CustomPaint(
                            isComplex: true,
                            painter: AxesPainter(scaleFactor),
                            child: Container(),
                          ),
                        ),
                        ...graphs.map(
                          (e) => Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: CustomPaint(
                              isComplex: true,
                              painter: GraphPainter(scaleFactor, e),
                              child: Container(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: CustomPaint(
                            isComplex: true,
                            painter: AxesPainter(scaleFactor),
                            child: Container(),
                          ),
                        ),
                        ...graphs.map(
                          (e) => Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: CustomPaint(
                              isComplex: true,
                              painter: GraphPainter(scaleFactor, e),
                              child: Container(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 300,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          color: Colors.black12,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: <Widget>[
                          ...graphs.map(
                            (e) => Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: GraphDataTile(
                                e,
                                onChange: onChange,
                                key: ValueKey<String>(e.id),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          RaisedButton(
                            onPressed: () {
                              setState(() {
                                graphs.add(
                                  Graph(
                                    id: const Uuid().v1(),
                                    color: Colors.blue,
                                    function: 'x^3',
                                    isVisible: true,
                                  ),
                                );
                              });
                            },
                            child: const Text('+ ADD MORE'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void onChange(Graph graph) {
    final index = graphs.indexOf(graph);

    graphs.remove(graph);
    setState(() {
      graphs.insert(index, graph);
    });
  }
}
