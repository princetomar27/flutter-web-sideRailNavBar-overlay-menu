import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwebrailnavmenu/rail_nav_bar_menu_item.dart';

class AppConfigurationCubit extends Cubit<List<RailNavbarMenuItem>> {
  AppConfigurationCubit({
    required this.defaultItems,
    this.customItems,
  }) : super(customItems ?? defaultItems);

  final List<RailNavbarMenuItem> defaultItems;
  final List<RailNavbarMenuItem>? customItems;
}
