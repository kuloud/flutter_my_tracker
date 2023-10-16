import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/pages/map/geo_location.dart';
import 'package:flutter_my_tracker/pages/map/main_ui.dart';
import 'package:flutter_my_tracker/pages/map/map_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 0;

  final _pages = <Widget>[
    const MapPage(),
    const MapPage(),
    const MapPage(),
    GeolocatorWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          useLegacyColorScheme: false,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.map),
                label: S.of(context).bottomNavigationBarLabelMap),
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: S.of(context).bottomNavigationBarLabelMap),
            BottomNavigationBarItem(
                icon: const Icon(Icons.track_changes),
                label: S.of(context).bottomNavigationBarLabelTracks),
            BottomNavigationBarItem(
                icon: const Icon(Icons.history),
                label: S.of(context).bottomNavigationBarLabelHistory),
          ]),
      // floatingActionButton: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {},
      //       child: const Icon(Icons.add),
      //     ),
      //     const SizedBox(
      //       height: 16,
      //       width: 16,
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {},
      //       child: const Icon(Icons.add),
      //     )
      //   ],
      // ),
    );
  }
}
