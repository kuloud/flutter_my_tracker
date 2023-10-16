import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/pages/map/main_ui.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapUiPage(),
      bottomNavigationBar:
          BottomNavigationBar(useLegacyColorScheme: false, items: [
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
    );
  }
}
