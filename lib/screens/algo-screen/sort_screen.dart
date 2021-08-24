import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/algorithm.dart';
import '../../providers/bottomNavBar_provider.dart';
import '../../providers/sort_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils.dart';
import 'ui_components.dart';

class SortingPage extends StatefulWidget {
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
      appBar: AppBar(
        title: const Text(
          'Sort',
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: Consumer(
              builder: (context, watch, child) {
                return DropdownButton<Algorithm>(
                  hint: const Text('Choose Sorting Algo'),
                  value: watch(sortProvider).algorithm,
                  onChanged: (newValue) {
                    print('new value is ${newValue?.name}');
                    context
                        .read(sortProvider.notifier)
                        .setSortFunction(newValue ?? sortAlgos.first);
                  },
                  items: sortAlgos
                      .where((e) => (e.algoType == AlgoType.sorting))
                      .map(
                        (e) => DropdownMenuItem<Algorithm>(
                          value: e,
                          child: Text(e.name),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, dimen) {
          if (dimen.maxWidth < 720) {
            return kIsWeb
                ? Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ListView(
                          children: [
                            SortingBarWidget(
                              dimen.maxHeight * 0.3,
                              dimen.maxWidth * 0.6,
                            ),
                            SortArrayWidget(),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SideBarWidget(),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            SortingBarWidget(
                              dimen.maxHeight * 0.3,
                              dimen.maxWidth * 0.6,
                            ),
                            SortArrayWidget(),
                          ],
                        ),
                      ),
                    ],
                  );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: ListView(
                    children: [
                      SortingBarWidget(
                        dimen.maxHeight * 0.3,
                        dimen.maxWidth * 0.5,
                      ),
                      SortArrayWidget(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SideBarWidget(),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: const AlgoBottomNavBar(),
      floatingActionButton: kIsWeb
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                showModalBottomSheet<SideBarWidget>(
                  context: context,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: SideBarWidget(),
                  ),
                );
              },
              child: Consumer(
                builder: (context, watch, child) {
                  return Icon(
                    Icons.more_horiz_rounded,
                    color: watch(themeProvider).theme.primaryColor,
                  );
                },
              ),
            ),
    );
  }
}

class AlgoBottomNavBar extends StatelessWidget {
  const AlgoBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      return Container(
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.1,
              blurRadius: 4.0,
            ),
          ],
          color: watch(themeProvider).primaryColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Tooltip(
                message: 'First Step',
                child: IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon: const Icon(
                    Icons.first_page_rounded,
                    size: 30,
                  ),
                  onPressed: () =>
                      context.read(sortProvider.notifier).firstStep(),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Tooltip(
                message: 'Previous Step',
                child: Consumer(
                  builder: (context, watch, child) {
                    return GestureDetector(
                      onLongPress: () async {
                        context
                            .read(bottomNavBarProvider.notifier)
                            .toggleIsPrevPressed();
                        do {
                          context.read(sortProvider.notifier).previousStep();
                          await Future<void>.delayed(
                            const Duration(milliseconds: 100),
                          );
                        } while (watch(bottomNavBarProvider).isPrevPressed);
                      },
                      onLongPressEnd: (val) {
                        context
                            .read(bottomNavBarProvider.notifier)
                            .toggleIsPrevPressed();
                      },
                      onTap: () =>
                          context.read(sortProvider.notifier).previousStep(),
                      child: const Icon(
                        Icons.fast_rewind_rounded,
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Consumer(
                builder: (context, watch, child) {
                  final val = watch(sortProvider).isSorting;
                  return IconButton(
                    padding: const EdgeInsets.all(0.0),
                    icon: !val
                        ? const Tooltip(
                            message: 'Play',
                            child: Icon(
                              Icons.play_arrow_rounded,
                              size: 30,
                            ),
                          )
                        : const Tooltip(
                            message: 'Pause',
                            child: Icon(
                              Icons.pause_rounded,
                              size: 30,
                            ),
                          ),
                    onPressed: val
                        ? () => context
                            .read(sortProvider.notifier)
                            .setIsSorting(false)
                        : () async =>
                            await context.read(sortProvider.notifier).play(),
                  );
                },
              ),
              const SizedBox(
                width: 12,
              ),
              Tooltip(
                message: 'Next Step',
                child: Consumer(
                  builder: (context, watch, child) {
                    return GestureDetector(
                      onLongPress: () async {
                        context
                            .read(bottomNavBarProvider.notifier)
                            .toggleIsNextPressed();
                        do {
                          context.read(sortProvider.notifier).nextStep();
                          await Future<void>.delayed(
                            const Duration(milliseconds: 100),
                          );
                        } while (watch(bottomNavBarProvider).isNextPressed);
                      },
                      onLongPressEnd: (val) {
                        context
                            .read(bottomNavBarProvider.notifier)
                            .toggleIsNextPressed();
                      },
                      onTap: () =>
                          context.read(sortProvider.notifier).nextStep(),
                      child: const Icon(
                        Icons.fast_forward_rounded,
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Tooltip(
                message: 'Last Step',
                child: IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon: const Icon(
                    Icons.last_page_rounded,
                    size: 30,
                  ),
                  onPressed: () =>
                      context.read(sortProvider.notifier).lastStep(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
