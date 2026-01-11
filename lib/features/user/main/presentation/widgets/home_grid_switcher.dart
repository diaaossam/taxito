import 'package:flutter/material.dart';
import 'package:aslol/core/utils/app_size.dart';

class HomeGridSwitcher extends StatefulWidget {
  final Widget gridView;
  final Widget listView;

  const HomeGridSwitcher({
    super.key,
    required this.gridView,
    required this.listView,
  });

  @override
  State<HomeGridSwitcher> createState() => _HomeGridSwitcherState();
}

class _HomeGridSwitcherState extends State<HomeGridSwitcher> {
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => isGrid = !isGrid),
                child: Icon(
                  Icons.list,
                  color: !isGrid
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(() => isGrid = !isGrid);
                },
                child: Icon(
                  Icons.grid_view,
                  color: isGrid
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: isGrid ? widget.gridView : widget.listView,
            ),
          ),
        ],
      ),
    );
  }
}
