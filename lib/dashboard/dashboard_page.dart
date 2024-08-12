import 'package:flutter/material.dart';
import 'dashboard_footer_page.dart';
import '../pages/home_page.dart';
import '../pages/settings_page.dart';
import '../rail_nav_bar/rail_nav_bar_menu_item.dart';
import '../rail_nav_bar/rail_nav_bar_menu_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SettingsPage(),
    const SettingsSubPage1(),
    const SettingsSubPage2(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<RailNavbarMenuItem> railNavbarMenuItemsList = [
      RailNavbarMenuItem(
        name: 'Home',
        iconPath: Icons.home,
        index: 0,
      ),
      RailNavbarMenuItem(
        name: 'Settings',
        iconPath: Icons.settings,
        index: 1,
        hoverItems: [
          HoverItemConfig(
            itemName: 'Sub-Settings 1',
            onTap: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
            itemRoute: _pages[2],
          ),
          HoverItemConfig(
            itemName: 'Sub-Settings 2',
            onTap: () {
              setState(() {
                _selectedIndex = 3;
              });
            },
            itemRoute: _pages[3],
          ),
        ],
      ),
    ];

    int mainMenuSelectedIndex =
        _selectedIndex < railNavbarMenuItemsList.length ? _selectedIndex : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      backgroundColor: Colors.grey,
      body: Row(
        children: [
          RailNavBarWidget(
            selectedIndex: mainMenuSelectedIndex,
            railNavbarMenuItemsList: railNavbarMenuItemsList,
            onItemSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: const DashboardFooterWidget(),
    );
  }
}
