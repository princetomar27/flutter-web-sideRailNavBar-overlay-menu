import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Page'),
    );
  }
}

class SettingsSubPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sub-Settings 1')),
      body: Center(child: Text('Content for Sub-Settings 1')),
    );
  }
}

class SettingsSubPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sub-Settings 2')),
      body: Center(child: Text('Content for Sub-Settings 2')),
    );
  }
}
