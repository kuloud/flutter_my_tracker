import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/pages/records/components/records_tab_view.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('运动记录'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: '周'),
              Tab(text: '月'),
              Tab(text: '年'),
              Tab(text: '总'),
            ],
          ),
        ),
        body: RecordsTabView(
          controller: _tabController,
        ),
      ),
    );
  }
}
