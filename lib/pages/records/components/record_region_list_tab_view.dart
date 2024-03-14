import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/pages/records/components/pojos/sub_tab_data.dart';
import 'package:flutter_my_tracker/pages/records/components/record_list_view.dart';

class RecordRegionListTabView extends StatefulWidget {
  const RecordRegionListTabView({super.key, required this.secondTabs});

  final List<SubTabData> secondTabs;

  @override
  State<RecordRegionListTabView> createState() =>
      _RecordRegionListTabViewState();
}

class _RecordRegionListTabViewState extends State<RecordRegionListTabView>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: 0, length: widget.secondTabs.length, vsync: this);
    _tabController?.index = widget.secondTabs.length - 1;
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            forceMaterialTransparency: true,
            automaticallyImplyLeading: false,
            floating: true,
            pinned: true,
            snap: true,
            primary: false,
            title: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: widget.secondTabs.reversed
                  .map((e) => Tab(
                        text: e.title,
                      ))
                  .toList(),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children:
            widget.secondTabs.map((e) => RecordListView(data: e)).toList(),
      ),
    );
  }
}
