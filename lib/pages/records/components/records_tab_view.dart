import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/pages/records/components/pojos/sub_tab_data.dart';
import 'package:flutter_my_tracker/providers/track_stat_provider.dart';

class RecordsTabView extends StatefulWidget {
  const RecordsTabView({super.key, this.controller});

  final TabController? controller;

  @override
  State<RecordsTabView> createState() => _RecordsTabViewState();
}

class _RecordsTabViewState extends State<RecordsTabView>
    with TickerProviderStateMixin {
  int pageType = 0; // 0 普通数据列表页 1 汇总页
  DateTime? startTime;
  DateTime? endTime;

  Future<List<SubTabData>?>? _getSecondTabs;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    widget.controller?.addListener(() {
      onFirstTabChanged();
    });
    onFirstTabChanged();
  }

  void onFirstTabChanged() {
    final firstTabIndex = widget.controller?.index;
    if (mounted) {
      setState(() {
        if (firstTabIndex == 3) {
          pageType = 1;
        } else {
          pageType = 0;
          _getSecondTabs =
              TrackStatProvider.instance().getSecondTabs(firstTabIndex);
        }
      });
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (pageType == 0) {
      return FutureBuilder(
          future: _getSecondTabs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final secondTabs = snapshot.data!;
              _tabController = TabController(
                  initialIndex: 0, length: secondTabs.length, vsync: this);
              _tabController?.index = secondTabs.length - 1;
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
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
                        tabs: secondTabs
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
                  children: secondTabs
                      .map((e) => Center(
                            child: Text(e.toString()),
                          ))
                      .toList(),
                ),
              );
            } else {
              return SizedBox();
            }
          });
    } else if (pageType == 1) {}
    return SizedBox();
  }
}
