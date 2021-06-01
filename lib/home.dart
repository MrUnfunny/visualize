import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';
import 'providers/theme_provider.dart';

class Home extends StatefulWidget {
  final List<Widget> _categoryTabs = [
    const Tab(
      text: 'Home',
    ),
    const Tab(
      text: 'Algorithms',
    ),
  ];
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _categoryController;
  @override
  void initState() {
    super.initState();
    _categoryController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final theme = watch(themeProvider);
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Visualize',
          ),
          actions: [
            IconButton(
              icon: theme.darkTheme
                  ? const Icon(Icons.light_mode)
                  : const Icon(
                      Icons.dark_mode,
                      color: Colors.grey,
                    ),
              onPressed: () =>
                  context.read(themeProvider.notifier).toggleTheme(),
            ),
          ],
          bottom: TabBar(
            controller: _categoryController,
            isScrollable: true,
            tabs: widget._categoryTabs,
          ),
        ),
        body: TabBarView(
          controller: _categoryController,
          children: <Widget>[
            HomePage(),
            HomePage(),
          ],
        ),
      );
    });
  }
}
