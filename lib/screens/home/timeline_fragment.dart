import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../boxes/media_box.dart';
import '../../main.dart';
import '../../misc.dart';
import '../../widgets/dynamic_grid.dart';
import '../../widgets/suggestion.dart';
import '../../widgets/wavy_divider.dart';
import 'home_screen.dart';

class HomeScreenTimelineFragment extends StatefulWidget {
  const HomeScreenTimelineFragment({super.key});

  @override
  State<HomeScreenTimelineFragment> createState() => _HomeScreenTimelineFragmentState();
}

class _HomeScreenTimelineFragmentState extends State<HomeScreenTimelineFragment> {
  @override
  Widget build(BuildContext context) {
    return HomeFragment(
      controlSafeArea: false,
      body: MediaQuery.removePadding(
        context: context,
        removeLeft: true,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              scrolledUnderElevation: 3,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 16/*button*/+4/*padding next to button*/+32/*idk*/),
                  const Text("Beshence Gallery"),
                  const SizedBox(width: 12,),
                  Icon(Icons.cloud_off_outlined, size: 16, color: Theme.of(context).colorScheme.secondary,)
                ],
              ),
              centerTitle: true,
              floating: true,
              pinned: !true,
              actions: [
                PopupMenuButton<String>(
                  onSelected: (value) {},
                  itemBuilder: (BuildContext context) {
                    return {"Settings"}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            ListenableBuilder(
              listenable: timelineChangeNotifier,
              builder: (BuildContext context, Widget? child) {
                return FutureBuilder(
                  future: mediaBox.getAllLocalMediaSorted(),
                  initialData: [],
                  builder: (context, snapshot) {
                    List<Widget> localItems = <Widget>[];
                    if(snapshot.hasData) {
                      for(LocalMedia item in snapshot.data!) {
                        try {
                          localItems.add(Image.memory(File(item.filePath).readAsBytesSync(), fit: BoxFit.cover,));
                        } catch(e) {
                          localItems.add(Text("error: ${item.id} ${item.modifiedAt}"));
                        }
                      }
                    }
                    return SliverSafeArea(
                      right: true,
                      top: false,
                      left: false,
                      bottom: false,
                      sliver: SliverList(
                          delegate: SliverChildListDelegate(
                              flatten([
                                if(true) Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                                child: Column(
                                                  children: [
                                                    const Icon(Icons.landscape, size: 32,),
                                                    const SizedBox(height: 24,),
                                                    RichText(
                                                        text: TextSpan(
                                                            style: TextStyle(fontSize: 24, height: 1.25, color: Theme.of(context).colorScheme.onPrimaryContainer),
                                                            text: "Welcome to\n",
                                                            children: const [
                                                              TextSpan(
                                                                  text: "Beshence Gallery",
                                                                  style: TextStyle(fontWeight: FontWeight.bold)
                                                              ),
                                                              TextSpan(text: "!")
                                                            ]
                                                        ),
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 16,),
                                                    Text(
                                                        "Let's start with these recommendations:",
                                                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(height: 24,),
                                                  ],
                                                )
                                            ),
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
                                          ]
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      child: SizedBox(
                                        child: WavyDivider(height: 2, color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(100), wavelength: 20,),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(padding: EdgeInsets.all(16), child: Text("Today"),),
                                DynamicGridView(
                                    maxWidthOnPortrait: 100,
                                    maxWidthOnLandscape: 150,
                                    sliver: false,
                                    spaceBetween: 2,
                                    children: List.generate(
                                        localItems.length, (index) =>
                                        Container(
                                            color: Color.fromARGB(255, Random().nextInt(255), Random.secure().nextInt(255), Random().nextInt(255)
                                            ),
                                            child: localItems[index]
                                        )
                                    )
                                )
                              ])
                          )
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}