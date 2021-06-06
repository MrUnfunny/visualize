import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '/graph/models/graph.dart';

class GraphDataTile extends StatefulWidget {
  final Graph graph;
  final void Function(Graph graph) onChange;

  GraphDataTile(this.graph,
      {required this.onChange, required ValueKey<String> key})
      : super(key: key);

  @override
  _GraphDataTileState createState() => _GraphDataTileState();
}

class _GraphDataTileState extends State<GraphDataTile> {
  TextEditingController _controller = TextEditingController();

  late Graph graph;

  @override
  void initState() {
    super.initState();
    graph = widget.graph;

    _controller = TextEditingController.fromValue(
      TextEditingValue(text: widget.graph.function),
    );
    _controller.addListener(() {
      graph = graph.copyWith(function: _controller.text);
      widget.onChange(
        widget.graph.copyWith(function: _controller.text),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: GestureDetector(
          onTap: () {
            showDialog<Widget>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Pick color'),
                content: SingleChildScrollView(
                  child: BlockPicker(
                    pickerColor: graph.color,
                    onColorChanged: changeColor,
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            );
          },
          child: Icon(
            Icons.graphic_eq,
            color: graph.color,
          ),
        ),
        title: Row(
          children: <Widget>[
            const Text('y='),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: graph.function,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              graph = graph.copyWith(isVisible: !graph.isVisible);
            });
            widget.onChange(graph);
          },
          child: Icon(
            graph.isVisible ? Icons.visibility : Icons.visibility_off,
            color: graph.color,
          ),
        ),
      ),
    );
  }

  void changeColor(Color color) {
    graph = graph.copyWith(color: color);
    widget.onChange(graph);
    Navigator.pop(context);
  }
}
