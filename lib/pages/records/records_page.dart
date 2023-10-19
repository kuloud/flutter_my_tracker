import 'package:flutter/material.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // 一级 Tab 的数量
      child: Scaffold(
        appBar: AppBar(
          title: const Text('二级 Tab 页示例'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '周'),
              Tab(text: '月'),
              Tab(text: '年'),
              Tab(text: '总'),
            ],
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                pinned: true,
                snap: true,
                primary: false,
                title: TabBar(
                  tabs: [
                    Tab(text: 'Tab 1'),
                    Tab(text: 'Tab 2'),
                    Tab(text: 'Tab 3'),
                    Tab(text: 'Tab 4'),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              // 周 Tab 的内容
              Center(child: Text('周 Tab')),
              // 月 Tab 的内容
              Center(child: Text('月 Tab')),
              // 年 Tab 的内容
              Center(child: Text('年 Tab')),
              // 总 Tab 的内容
              Center(child: Text('总 Tab')),
            ],
          ),
        ),
      ),
    );
  }
}
