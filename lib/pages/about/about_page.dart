import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/components/empty_view.dart';
import 'package:flutter_my_tracker/utils/app.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于'),
      ),
      body: Material(
        child: FutureBuilder(
            future: getAppVersion(),
            builder: ((context, snapshot) {
              return Align(
                alignment: const FractionalOffset(0.5, 0.3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: EmptyView(),
                    ),
                    Text(snapshot.data ?? ''),
                  ],
                ),
              );
            })),
      ),
    );
  }
}
