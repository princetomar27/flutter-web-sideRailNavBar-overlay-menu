import 'package:flutter/widgets.dart';

class RailNavbarMenuItem {
  final String name;
  final IconData iconPath;
  final List<HoverItemConfig>? hoverItems;
  final int index;

  RailNavbarMenuItem({
    required this.name,
    required this.iconPath,
    this.hoverItems,
    required this.index,
  });
}

class HoverItemConfig {
  final String itemName;
  final VoidCallback onTap;
  final Widget itemRoute;
  final Color? backgroundColor;
  final Color? hoverColor;
  final Widget? prefixIcon;
  final Color? titleTextColor;
  final bool isHoverColorGradient;

  HoverItemConfig({
    required this.itemName,
    required this.onTap,
    required this.itemRoute,
    this.backgroundColor,
    this.hoverColor,
    this.prefixIcon,
    this.titleTextColor,
    this.isHoverColorGradient = true,
  });
}
