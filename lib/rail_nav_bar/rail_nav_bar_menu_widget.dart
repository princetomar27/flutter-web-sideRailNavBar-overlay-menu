import 'dart:async';
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
  final List<GlobalKey> _hoverKeys = [];
  bool _isInOverlay = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.railNavbarMenuItemsList.length; i++) {
      _hoverKeys.add(GlobalKey());
    }
  }

  void _showOverlay(
      BuildContext context, List<HoverItemConfig> hoverItems, int index) {
    final renderBox =
        _hoverKeys[index].currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return;
    }
    final globalOffset = renderBox.localToGlobal(Offset.zero);

    const itemHeight = 50.0;
    const verticalPadding = 12.0;
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

    final overlayAnimationController = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 200),
    );
    final fadeAnimation = CurvedAnimation(
      parent: overlayAnimationController,
      curve: Curves.easeInOut,
    );
    final scaleAnimation =
        Tween<double>(begin: 0.95, end: 1.0).animate(fadeAnimation);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: globalOffset.dx + kNavigationActionWidth - 15,
        top: railActionPositionFromTop,
        child: MouseRegion(
          onEnter: (_) {
            _isInOverlay = true;
            _timer?.cancel();
          },
          onExit: (_) {
            _isInOverlay = false;
            _removeOverlay();
          },
          child: Material(
            color: Colors.transparent,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height *
                        0.5, // max 50% of screen
                    minWidth: 200,
                    maxWidth: 240,
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha((0.95 * 255).toInt()),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.15 * 255).toInt()),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: hoverItems.map((hoverItem) {
                          bool isHovered = false;
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return MouseRegion(
                                onEnter: (_) {
                                  setState(() {
                                    isHovered = true;
                                  });
                                },
                                onExit: (_) {
                                  setState(() {
                                    isHovered = false;
                                  });
                                },
                                child: AnimatedScale(
                                  scale: isHovered ? 1.04 : 1.0,
                                  duration: const Duration(milliseconds: 120),
                                  curve: Curves.easeOut,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: isHovered
                                          ? (hoverItem.hoverColor != null
                                              ? (hoverItem.isHoverColorGradient
                                                  ? LinearGradient(
                                                      colors: [
                                                        hoverItem.hoverColor!,
                                                        Color.lerp(
                                                            hoverItem
                                                                .hoverColor!,
                                                            Colors.white,
                                                            0.7)!,
                                                      ],
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                    )
                                                  : null)
                                              : (hoverItem.backgroundColor !=
                                                      null
                                                  ? LinearGradient(
                                                      colors: [
                                                        hoverItem
                                                            .backgroundColor!,
                                                        Color.lerp(
                                                            hoverItem
                                                                .backgroundColor!,
                                                            Colors.white,
                                                            0.8)!,
                                                      ],
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                    )
                                                  : LinearGradient(
                                                      colors: [
                                                        Colors.cyan.shade50,
                                                        Colors.white,
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                    )))
                                          : null,
                                      color: isHovered
                                          ? (hoverItem.hoverColor != null &&
                                                  !hoverItem
                                                      .isHoverColorGradient
                                              ? hoverItem.hoverColor
                                              : null)
                                          : (hoverItem.backgroundColor ??
                                              Colors.cyan.shade900),
                                      border: Border.all(
                                        color: hoverItem.backgroundColor != null
                                            ? Color.lerp(
                                                hoverItem.backgroundColor!,
                                                Colors.black,
                                                0.25)!
                                            : Colors.cyan.shade900,
                                      ),
                                      boxShadow: isHovered
                                          ? [
                                              BoxShadow(
                                                color: (hoverItem
                                                                .backgroundColor !=
                                                            null
                                                        ? Color.lerp(
                                                            hoverItem
                                                                .backgroundColor!,
                                                            Colors.black,
                                                            0.18)!
                                                        : Colors.cyan.shade900)
                                                    .withAlpha(
                                                        (0.10 * 255).toInt()),
                                                blurRadius: 12,
                                                offset: const Offset(0, 4),
                                              ),
                                            ]
                                          : [],
                                    ),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 2),
                                      leading: hoverItem.prefixIcon,
                                      title: Text(
                                        hoverItem.itemName,
                                        style: TextStyle(
                                          color: hoverItem.titleTextColor ??
                                              (isHovered
                                                  ? (hoverItem.hoverColor !=
                                                          null
                                                      ? Colors.white
                                                      : Colors.cyan.shade900)
                                                  : Colors.white),
                                          fontWeight: isHovered
                                              ? FontWeight.bold
                                              : FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                      onTap: () {
                                        hoverItem.onTap();
                                        _removeOverlay();
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    overlayAnimationController.forward();
  }

  void _removeOverlay() {
    if (_isInOverlay) return;
    _timer = Timer(const Duration(milliseconds: 200), () {
      if (!_isInOverlay) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: widget.onItemSelected,
      labelType: NavigationRailLabelType.all,
      destinations: widget.railNavbarMenuItemsList.asMap().entries.map(
        (entry) {
          int index = entry.key;
          RailNavbarMenuItem item = entry.value;
          return NavigationRailDestination(
            icon: SizedBox(
              height: kBottomNavigationBarHeight,
              child: MouseRegion(
                key: _hoverKeys[index],
                onEnter: (event) {
                  setState(() {});
                  if (item.hoverItems != null && item.hoverItems!.isNotEmpty) {
                    final renderBox = _hoverKeys[index]
                        .currentContext
                        ?.findRenderObject() as RenderBox?;
                    if (renderBox != null) {
                      _showOverlay(context, item.hoverItems!, index);
                    }
                  }
                },
                onExit: (event) {
                  _removeOverlay();
                },
                child: GestureDetector(
                  onTap: () => widget.onItemSelected(item.index),
                  child: Icon(item.iconPath),
                ),
              ),
            ),
            label: Text(item.name),
          );
        },
      ).toList(),
    );
  }
}
