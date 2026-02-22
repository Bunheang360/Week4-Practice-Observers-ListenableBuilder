import 'package:flutter/material.dart';

import 'ui/providers/theme_color_provider.dart';
import 'ui/screens/settings/settings_screen.dart';
import 'ui/screens/downloads/downloads_screen.dart';
import 'ui/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 1;

  final List<Widget> _pages =  [DownloadsScreen(), SettingsScreen()];

  @override
  void initState() {
    super.initState();
    themeColorProvider.addListener(_onThemeChanged);
  }

  void _onThemeChanged() {
    setState(() {
      
    });
  }

  @override
  void dispose() {
    themeColorProvider.removeListener(_onThemeChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(
        body: _pages[_currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: themeColorProvider.currentThemeColor.color,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Downloads'),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
