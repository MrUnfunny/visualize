import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bubble.dart';
import 'provider.dart';
import 'themeData.dart';

Future<void> main() async {
  var prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(child: MyApp(prefs)));
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
      debugShowCheckedModeBanner: false,
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF2FA),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (context, dimen) {
          if (dimen.maxWidth < 720) {
            return Column(
              children: getChildren(
                minHeight: dimen.maxHeight * 0.2,
                maxWidth: dimen.maxWidth * 0.6,
              ),
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: getChildren(
                minHeight: dimen.maxHeight * 0.5,
                maxWidth: dimen.maxWidth * 0.6,
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.1,
              blurRadius: 4.0,
            ),
          ],
          color: Colors.white,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.fast_rewind,
                  size: 30,
                ),
                onPressed: () =>
                    context.read(sortProvider.notifier).previousStep(),
              ),
              const SizedBox(
                width: 24,
              ),
              Consumer(
                builder: (context, watch, child) {
                  final val = watch(sortProvider).isSorting;
                  return IconButton(
                    icon: !val
                        ? const Icon(
                            Icons.play_arrow,
                            size: 30,
                          )
                        : const Icon(
                            Icons.pause,
                            size: 30,
                          ),
                    onPressed: val ? pause : play,
                  );
                },
              ),
              const SizedBox(
                width: 24,
              ),
              IconButton(
                icon: const Icon(
                  Icons.fast_forward,
                  size: 30,
                ),
                onPressed: () => context.read(sortProvider.notifier).nextStep(),
              ),
              const SizedBox(
                width: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getChildren(
      {required double minHeight, required double maxWidth}) {
    return [
      Expanded(
        flex: 2,
        child: ListView(
          children: [
            SortingBarWidget(minHeight, maxWidth),
            SortArrayWidget(),
            SortReasonWidget(),
          ],
        ),
      ),
      SideBarWidget()
    ];
  }

  void play() async {
    var val = bubbleSort(context.read(sortProvider).current.list);
    context.read(sortProvider.notifier).updateIterator(val);

    await context.read(sortProvider.notifier).play();
  }

  void pause() async {
    context.read(sortProvider.notifier).setIsSorting(false);
  }
}

class SideBarWidget extends StatelessWidget {
  // final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Consumer(
        builder: (context, watch, child) {
          final val = watch(sortProvider);
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(32),
            child: ListView(
              children: [
                Text(
                  'Elements',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Slider(
                  min: 2,
                  max: 40,
                  activeColor: Theme.of(context).accentColor,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    context.read(sortProvider.notifier).createSortItems(
                          context,
                          bubbleSort,
                          value.floor(),
                        );
                  },
                  value: val.current.list.length.toDouble(),
                ),
                Center(
                  child: Text('${val.current.list.length} elements'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                Text(
                  'Delay',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Slider(
                  min: 50,
                  max: 700,
                  activeColor: Theme.of(context).accentColor,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    context.read(sortProvider.notifier).setDelay(value.toInt());
                  },
                  value: val.delay.toDouble(),
                ),
                Center(
                  child: Text('${val.delay} ms'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                // Text(
                //   'Create',
                //   style: Theme.of(context).textTheme.headline5!.copyWith(
                //         fontWeight: FontWeight.w600,
                //       ),
                // ),
                // const SizedBox(
                //   height: 16,
                // ),
                // TextField(
                //   controller: _controller,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     hintText: 'Input Array elements seperted by comma',
                //   ),
                //   onSubmitted: (val) {
                //     final arr = val.split(',');
                //     arr.forEach((e) {double.tryParse(e)!=null;});
                //   },
                // ),
                // const SizedBox(
                //   height: 24,
                // ),
                // ElevatedButton(
                //   onPressed: () {},
                //   child: const Text('Create Array'),
                // )
              ],
            ),
          );
        },
      ),
    );
  }
}

class SortReasonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(32.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 16,
      ),
      child: Center(
        child: Consumer(builder: (context, watch, child) {
          final msg = watch(sortProvider).message;
          return Text(
            msg,
          );
        }),
      ),
    );
  }
}

class SortArrayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(32.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 16,
      ),
      child: Center(
        child: Consumer(
          builder: (context, watch, child) {
            final val = watch(sortProvider).current.list;
            return Wrap(
              children: val
                  .map(
                    (e) => Container(
                      margin: const EdgeInsets.all(0.8),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: e.color,
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
            );
          },
        ),
      ),
    );
  }
}

class SortingBarWidget extends StatelessWidget {
  final double minHeight;
  final double maxWidth;

  SortingBarWidget(this.minHeight, this.maxWidth);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: minHeight),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(32.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 16,
      ),
      child: Center(
        child: Consumer(
          builder: (context, watch, child) {
            final val = watch(sortProvider).current.list;

            return Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              runAlignment: WrapAlignment.spaceEvenly,
              runSpacing: 20,
              children: val
                  .map(
                    (e) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      height: e.value + 1,
                      width: maxWidth / (2 * val.length + 1),
                      color: e.color,
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
