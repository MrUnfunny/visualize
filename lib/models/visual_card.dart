import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/sort_provider.dart';
import '../screens/algo-screen/sort_screen.dart';
import 'algorithm.dart';

class VisualCard extends StatefulWidget {
  final Algorithm algorithm;
  VisualCard({
    required this.algorithm,
  });

  @override
  _VisualCardState createState() => _VisualCardState();
}

class _VisualCardState extends State<VisualCard> {
  late Offset _tapPosition;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTapDown: (details) => _tapPosition = details.globalPosition,
        onLongPress: () {
          final x = _tapPosition.dx;
          final y = _tapPosition.dy;
          showMenu<String>(
            position: RelativeRect.fromLTRB(x, y, x + 1, y + 1),
            items: <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: '_index',
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.launch),
                    TextButton(
                      onPressed: () async {
                        final url = widget.algorithm.url;
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: Text(
                        '   Get more information',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
            context: context,
          );
        },
        onTap: () {
          context.read(sortProvider.notifier).setSortFunction(widget.algorithm);
          Navigator.push<Widget>(
            context,
            MaterialPageRoute(
              builder: (context) => SortingPage(),
            ),
          );
        },
        child: Card(
          elevation: 5,
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 10,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                  // TODO: create dark mode gifs and add
                  child: widget.algorithm.image == 'image'
                      ? const Placeholder()
                      : Image.asset(
                          widget.algorithm.image,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  child: Center(
                    child: FittedBox(
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.fitWidth,
                      child: Text(
                        widget.algorithm.name,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
