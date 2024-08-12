import 'package:flutter/material.dart';
import 'rail_nav_bar_menu_item.dart';

class RailNavBarWidget extends StatefulWidget {
  final int selectedIndex;
  final List<RailNavbarMenuItem> railNavbarMenuItemsList;
  final ValueChanged<int> onItemSelected;

  const RailNavBarWidget({
    super.key,
    required this.selectedIndex,
    required this.railNavbarMenuItemsList,
    required this.onItemSelected,
  });

  @override
  RailNavBarWidgetState createState() => RailNavBarWidgetState();
}

const kNavigationActionWidth = 80.0;

class RailNavBarWidgetState extends State<RailNavBarWidget> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _hoverKey = GlobalKey();

  void _showOverlay(
      BuildContext context, List<HoverItemConfig> hoverItems, Offset position) {
    final RenderBox? renderBox =
        _hoverKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return;
    }
    final globalOffset = renderBox.localToGlobal(Offset.zero);

    const itemHeight = 56.0;
    const verticalPadding = 4.0;
    final containerHeight =
        (hoverItems.length * itemHeight) + (2 * verticalPadding);

    double railActionPositionFromTop;
    final currentScreenHeight = MediaQuery.of(context).size.height;
    final currentRailActionItemSpaceLeftFromBottom =
        currentScreenHeight - globalOffset.dy;

    if (currentRailActionItemSpaceLeftFromBottom < containerHeight) {
      railActionPositionFromTop = globalOffset.dy -
          (containerHeight) +
          kBottomNavigationBarHeight / 1.5;
    } else {
      railActionPositionFromTop = globalOffset.dy;
    }

    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: globalOffset.dx + kNavigationActionWidth - 15,
        top: railActionPositionFromTop,
        child: MouseRegion(
          onEnter: (_) {
            setState(() {});
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: containerHeight,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.black45,
                  )),
              width: 200,
              child: Column(
                children: hoverItems.map((hoverItem) {
                  return ListTile(
                    title: Text(hoverItem.itemName),
                    onTap: hoverItem.onTap,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: widget.onItemSelected,
      labelType: NavigationRailLabelType.all,
      destinations: widget.railNavbarMenuItemsList
          .map(
            (item) => NavigationRailDestination(
              icon: MouseRegion(
                key: _hoverKey,
                onEnter: (event) {
                  if (item.hoverItems != null && item.hoverItems!.isNotEmpty) {
                    final RenderBox? renderBox = _hoverKey.currentContext
                        ?.findRenderObject() as RenderBox?;
                    if (renderBox != null) {
                      final Offset position =
                          renderBox.localToGlobal(Offset.zero);
                      _showOverlay(context, item.hoverItems!, position);
                    } else {
                      _removeOverlay();
                    }
                  } else {
                    _removeOverlay();
                  }
                },
                onExit: (event) => _removeOverlay(),
                child: GestureDetector(
                  onTap: () => widget.onItemSelected(item.index),
                  child: Icon(item.iconPath),
                ),
              ),
              label: Text(item.name),
            ),
          )
          .toList(),
    );
  }
}
