import 'package:flutter/material.dart';
import 'rail_nav_bar_menu_item.dart';

class RailNavHoverSideWidget extends StatefulWidget {
  final List<HoverItemConfig> hoverItems;

  const RailNavHoverSideWidget({
    super.key,
    required this.hoverItems,
  });

  @override
  State<RailNavHoverSideWidget> createState() => _RailNavHoverSideWidgetState();
}

class _RailNavHoverSideWidgetState extends State<RailNavHoverSideWidget> {
  int sltIndex = -1;
  int hoverIndex = -1;

  @override
  Widget build(BuildContext context) {
    const itemHeight = 28.0;
    final containerHeight = (widget.hoverItems.length * itemHeight);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.cyan.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      height: containerHeight,
      width: 200,
      child: ListView.builder(
        itemCount: widget.hoverItems.length,
        itemBuilder: (context, index) {
          final selectedIndex = sltIndex == index;
          final isHovering = hoverIndex == index;
          return MouseRegion(
            onEnter: (_) {
              setState(() {
                hoverIndex = index;
              });
            },
            onExit: (_) {
              setState(() {
                hoverIndex = -1;
              });
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  sltIndex = index;
                });
                widget.hoverItems[index].onTap();
              },
              child: Container(
                height: itemHeight,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selectedIndex || isHovering
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      widget.hoverItems[index].itemName,
                      style: TextStyle(
                        color: selectedIndex || isHovering
                            ? Colors.cyan.shade800
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
