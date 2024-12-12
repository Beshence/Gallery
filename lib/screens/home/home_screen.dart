import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';

import 'fragments/library_fragment.dart';
import 'fragments/search_fragment.dart';
import 'fragments/timeline_fragment.dart';
import 'fragments/tools_fragment.dart';

StatefulShellRoute homeScreenRoute = StatefulShellRoute.indexedStack(
    builder: (BuildContext context, GoRouterState state,
        StatefulNavigationShell navigationShell) {
      return HomeScreen(navigationShell: navigationShell);
    },
    branches: List<StatefulShellBranch>.generate(
        destinations.length,
        (index) => shellBranchWithFragment(
            destinations[index].fragment, destinations[index].path)));

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  Future<void> _requestAssets() async {

    // Request permissions.
    final PermissionState ps = await PhotoManager.requestPermissionExtend();

    // Further requests can be only proceed with authorized or limited.
    if (!ps.hasAccess) {

      print('Permission is not accessible.');
      return;
    }
    // Customize your own filter options.
    final PMFilter filter = FilterOptionGroup(
      imageOption: const FilterOption(
        sizeConstraint: SizeConstraint(ignoreSize: true),
      ),
    );
    // Obtain assets using the path entity.
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
    );
    // Return if not paths found.
    if (paths.isEmpty) {
      print('No paths found.');
      return;
    }
    var _path = paths.first;
    var _totalEntitiesCount = await _path.assetCountAsync;
    final List<AssetEntity> entities = await _path.getAssetListPaged(
      page: 0,
      size: 1000,
    );
    print(_path);
    print(_totalEntitiesCount);
    for(AssetEntity entity in entities) {
      print(entity.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.portrait // нормальное положение
        ? Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _requestAssets,
          child: const Icon(Icons.developer_board),
        ),
            body: navigationShell,
            bottomNavigationBar: NavigationBar(
                elevation: 3,
                onDestinationSelected: (int index) => _onTap(context, index),
                selectedIndex: navigationShell.currentIndex,
                destinations: List.generate(
                    destinations.length,
                    (index) => NavigationDestination(
                        icon: destinations[index].icon,
                        label: destinations[index].label,
                        selectedIcon: destinations[index].selectedIcon))))
        : Scaffold( // ютуб-положение
      floatingActionButton: FloatingActionButton(
        onPressed: _requestAssets,
        child: const Icon(Icons.developer_board),
      ),
            appBar: AppBar(
              elevation: 1,
              scrolledUnderElevation: 3,
              title: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.landscape),
                    SizedBox(width: 28),
                    Text("Beshence Gallery"),
                  ],
                ),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle_outlined, size: 32)),
                const SizedBox(width: 4),
              ],
            ),
            body: Row(
              children: [
                Column(mainAxisSize: MainAxisSize.min, children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Material(
                      child: NavigationRail(
                        backgroundColor: ElevationOverlay.applySurfaceTint(Theme.of(context).colorScheme.background, Theme.of(context).colorScheme.surfaceTint, 1),
                        labelType: NavigationRailLabelType.selected,
                        selectedIndex: navigationShell.currentIndex,
                        onDestinationSelected: (int index) =>
                            _onTap(context, index),
                        destinations: List.generate(
                          destinations.length,
                          (index) => NavigationRailDestination(
                            icon: destinations[index].icon,
                            label: Text(destinations[index].label),
                            selectedIcon: destinations[index].selectedIcon,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
                Expanded(child: navigationShell)
              ],
            ),
          );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

StatefulShellBranch shellBranchWithFragment(Widget fragment, String link) {
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        path: link,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: fragment,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity:
                    CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
    ],
  );
}

class Destination {
  final String label;
  final Icon icon;
  final Icon selectedIcon;
  final String path;
  final Widget fragment;

  const Destination(
      this.label, this.icon, this.selectedIcon, this.path, this.fragment);
}

List<Destination> destinations = const [
  Destination("Timeline", Icon(Icons.photo_outlined), Icon(Icons.photo),
      "/timeline", HomeScreenTimelineFragment()),
  Destination("Library", Icon(Icons.perm_media_outlined),
      Icon(Icons.perm_media), "/library", HomeScreenLibraryFragment()),
  Destination("Search", Icon(Icons.search_outlined), Icon(Icons.search),
      "/search", HomeScreenSearchFragment()),
  Destination("Tools", Icon(Icons.handyman_outlined), Icon(Icons.handyman),
      "/tools", HomeScreenToolsFragment())
];
