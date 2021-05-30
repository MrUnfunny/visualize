import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/bottomNavBar_provider.dart';
import '../../providers/sort_provider.dart';
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
      backgroundColor: const Color(0xFFEFF2FA),
      appBar: AppBar(
        title: const Text(
          'Visualize',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: Consumer(
              builder: (context, watch, child) {
                return DropdownButton<String>(
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  hint: const Text('Choose Sorting Algo'),
                  value: watch(sortProvider).algoName,
                  onChanged: (newValue) {
                    print('new value is $newValue');
                    newValue ??= 'Bubble Sort';

                    context
                        .read(sortProvider.notifier)
                        .setSortFunction(newValue);
                  },
                  items: sortAlgos.keys
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
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
                  barrierColor: Colors.black12,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: SideBarWidget(),
                  ),
                );
              },
              child: const Icon(
                Icons.more_horiz_rounded,
                color: Colors.white,
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
    return Container(
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
                    onTap: () => context.read(sortProvider.notifier).nextStep(),
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
                onPressed: () => context.read(sortProvider.notifier).lastStep(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
