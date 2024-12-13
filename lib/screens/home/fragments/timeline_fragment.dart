import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gallery/misc.dart';

import '../../../widgets/dynamic_grid.dart';
import '../../../widgets/suggestion.dart';
import '../home_app_bar.dart';

class HomeScreenTimelineFragment extends StatefulWidget {
  const HomeScreenTimelineFragment({super.key});

  @override
  State<HomeScreenTimelineFragment> createState() => _HomeScreenTimelineFragmentState();
}

class _FloatingHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _FloatingHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 60.0; // Высота заголовка
  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true; // Указывается, нужно ли пересоздавать заголовок
  }
}

class _HomeScreenTimelineFragmentState extends State<HomeScreenTimelineFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
              slivers: [
                HomeAppBar(title: "Timeline", floating: MediaQuery.orientationOf(context) == Orientation.portrait),
                /*SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: _FloatingHeaderDelegate(
                    child: Container(
                      color: Colors.amber,
                      alignment: Alignment.center,
                      child: const Text('Floating Header'),
                    ),
                  ),
                ),*/
                SliverList(
                  delegate: SliverChildListDelegate(
                      flatten([
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DynamicGridView(
                                    maxWidthOnPortrait: 300,
                                    maxWidthOnLandscape: 400,
                                    sliver: false,
                                    height: const DynamicGridViewHeight.fixed(84),
                                    spaceBetween: 16,
                                    children: [
                                      if (/*suggestions.contains("permission")*/true) Suggestion(
                                          icon: Icon(Icons.lightbulb_outlined, color: Theme.of(context).textTheme.bodySmall?.color),
                                          title: "Give access to your photos and videos",
                                          button: IconButton.filled(onPressed: () => {}, icon: const Icon(Icons.navigate_next)),
                                          cancelButton: IconButton(icon: const Icon(Icons.close), onPressed: () => {}/*setState(() => suggestions.remove("permission"))*/)
                                      ),
                                      if(/*suggestions.contains("account")*/true) Suggestion(
                                          icon: Icon(Icons.lightbulb_outlined, color: Theme.of(context).textTheme.bodySmall?.color),
                                          title: "Sign in to synchronise",
                                          button: IconButton.filled(onPressed: () => {}, icon: const Icon(Icons.navigate_next)),
                                          cancelButton: IconButton(icon: const Icon(Icons.close), onPressed: () => {}/*setState(() => suggestions.remove("account"))*/)
                                      ),
                                    ]
                                ),
                                const SizedBox(height: 16)
                              ]
                          ),
                        ),
                        List.generate(100, (index) => [Text("$index"), DynamicGridView(maxWidthOnPortrait: 100, maxWidthOnLandscape: 150, sliver: false, spaceBetween: 2, children: List.generate(Random().nextInt(9)+2, (index) => Container(color: Color.fromARGB(255, Random().nextInt(255), Random.secure().nextInt(255), Random().nextInt(255)))))])]).cast()
                  )
                ),
                /*SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: _FloatingHeaderDelegate(
                    child: Container(
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: const Text('Floating Header'),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate(
                        flatten(List.generate(100, (index) => [Text("$index"), DynamicGridView(maxWidthOnPortrait: 100, maxWidthOnLandscape: 150, sliver: false, spaceBetween: 2, children: List.generate(Random().nextInt(9)+2, (index) => Container(color: Color.fromARGB(255, Random().nextInt(255), Random.secure().nextInt(255), Random().nextInt(255)))))])).cast()
                    )
                ),*/
              ]
          ),
        ],
      ),
    );
  }
}