import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_tracker/cubit/locale/locale_cubit.dart';
import 'package:flutter_my_tracker/pages/records/components/pojos/sub_tab_data.dart';
import 'package:flutter_my_tracker/pages/records/components/record_region_list_tab_view.dart';
import 'package:flutter_my_tracker/pages/records/components/summary_tab_view.dart';
import 'package:flutter_my_tracker/providers/track_stat_provider.dart';

class RecordsTabView extends StatefulWidget {
  const RecordsTabView({super.key, this.controller});

  final TabController? controller;

  @override
  State<RecordsTabView> createState() => _RecordsTabViewState();
}

class _RecordsTabViewState extends State<RecordsTabView> {
  int pageType = 0; // 0 普通数据列表页 1 汇总页
  DateTime? startTime;
  DateTime? endTime;

  Future<List<SubTabData>?>? _getSecondTabs;

  @override
  void initState() {
    super.initState();

    widget.controller?.addListener(() {
      if (widget.controller?.indexIsChanging ?? false) {
        onFirstTabChanged();
      }
    });
    onFirstTabChanged();
  }

  void onFirstTabChanged() {
    if (mounted) {
      setState(() {
        final firstTabIndex = widget.controller?.index;
        if (firstTabIndex == 3) {
          pageType = 1;
        } else {
          pageType = 0;
          _getSecondTabs = TrackStatProvider.instance().getSecondTabs(
              BlocProvider.of<LocaleCubit>(context)
                  .state
                  .locale
                  .toLanguageTag(),
              firstTabIndex);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (pageType == 0) {
      return FutureBuilder(
          key: UniqueKey(),
          future: _getSecondTabs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final secondTabs = snapshot.data!;
              return RecordRegionListTabView(
                secondTabs: secondTabs,
              );
            } else {
              return const SizedBox();
            }
          });
    } else if (pageType == 1) {
      return const SummaryTabView();
    }
    return const SizedBox();
  }
}
