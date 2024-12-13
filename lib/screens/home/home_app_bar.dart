import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final String title;
  final bool floating;

  const HomeAppBar({super.key, required this.title, this.floating = false});

  @override
  Widget build(context) {
    return SliverAppBar(
      scrolledUnderElevation: 3,
      title: Row(
        children: [
          if (MediaQuery.orientationOf(context) == Orientation.portrait) const Icon(Icons.landscape),
          if (MediaQuery.orientationOf(context) == Orientation.portrait) const SizedBox(width: 8),
          Text(title),
        ],
      ),
      floating: floating,
      pinned: !floating,
      actions: [
        //IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle_outlined, size: 32)),
        //const SizedBox(width: 4),
        PopupMenuItem(child: Icon(Icons.account_circle_outlined, size: 32), onTap: () {},)
      ],
    );
  }
}