import 'package:flutter/material.dart';
import 'dashboard_footer_page.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'rail_nav_bar_menu_item.dart';
import 'rail_nav_bar_menu_widget.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SettingsPage(),
    // Add more pages here
  ];

  @override
  Widget build(BuildContext context) {
    final List<RailNavbarMenuItem> railNavbarMenuItemsList = [
      RailNavbarMenuItem(
        name: 'Home',
        iconPath:
            Icons.home, // Use an icon directly or replace with your icon path
        index: 0,
      ),
      RailNavbarMenuItem(
        name: 'Settings',
        iconPath: Icons
            .settings, // Use an icon directly or replace with your icon path
        index: 1,
        hoverItems: [
          HoverItemConfig(
            itemName: 'Sub-Settings 1',
            onTap: () {
              print('Sub settings 1');
            },
            itemRoute: SettingsSubPage1(), // Replace with actual route widget
          ),
          HoverItemConfig(
            itemName: 'Sub-Settings 2',
            onTap: () {
              print('Sub settings 2');
            },
            itemRoute: SettingsSubPage2(), // Replace with actual route widget
          ),
        ],
      ),
      // Add more items as needed
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Row(
        children: [
          RailNavBarWidget(
            selectedIndex: _selectedIndex,
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
