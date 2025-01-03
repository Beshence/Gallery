import 'package:flutter/material.dart';

import 'home_screen.dart';

class HomeScreenLibraryFragment extends StatefulWidget {
  const HomeScreenLibraryFragment({super.key});

  @override
  State<HomeScreenLibraryFragment> createState() => _HomeScreenLibraryFragmentState();
}

class _HomeScreenLibraryFragmentState extends State<HomeScreenLibraryFragment> {
  @override
  Widget build(BuildContext context) {
    return HomeFragment(
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
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
          centerTitle: true,
          title: const Text("Library"),
        ),
        body: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text("Albums on device", style: Theme.of(context).textTheme.labelLarge, maxLines: 1, softWrap: false,),
                      ),
                      const SizedBox(height: 10000,)
                    ]
                ),
              ),
            ]
        )
    );
  }
}