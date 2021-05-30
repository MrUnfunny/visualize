import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/sort_provider.dart';
import '../../utils.dart';

class SideBarWidget extends StatelessWidget {
  // final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final val = watch(sortProvider);
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: (kIsWeb)
              ? const EdgeInsets.all(32)
              : (Platform.isAndroid || Platform.isIOS)
                  ? const EdgeInsets.all(16)
                  : const EdgeInsets.all(32),
          child: ListView(
            children: [
              Text(
                'Elements',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Slider(
                min: 7,
                max: 50,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  context.read(sortProvider.notifier).createSortItems(
                        context,
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
                min: 20,
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
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Consumer(
          builder: (context, watch, child) {
            final msg = watch(sortProvider).message;
            return Text(
              msg,
              style: GoogleFonts.comicNeue().copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: matchActiveColor,
              ),
            );
          },
        ),
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

            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: val
                      .map(
                        (e) => Container(
                          height: e.value + 1,
                          width: maxWidth / (1.8 * val.length + 1),
                          color: e.color,
                        ),
                      )
                      .toList(),
                ),
                SortReasonWidget()
              ],
            );
          },
        ),
      ),
    );
  }
}
