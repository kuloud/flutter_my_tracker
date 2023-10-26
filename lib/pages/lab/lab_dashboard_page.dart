import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/pages/detail/components/main_info_card.dart';
import 'package:flutter_my_tracker/pages/detail/components/trajectory/color_label.dart';
import 'package:flutter_my_tracker/pages/detail/components/trajectory/trajectory_panel.dart';
import 'package:flutter_my_tracker/pages/lab/components/track_generator.dart';

class LabDashboardPage extends StatefulWidget {
  const LabDashboardPage({super.key});

  @override
  State<LabDashboardPage> createState() => _LabDashboardPageState();
}

class _LabDashboardPageState extends State<LabDashboardPage> {
  Future<List<Position>?>? _fetchTrackPoints;
  bool isAxisShow = false;

  String initialAltitude = '0.0';
  String finalAltitude = '0.0';
  String maxPace = '4.0';
  String minPace = '6.0';
  String averagePace = '5.0';
  String timeDuration = '10';

  List<String> altitudeOptions = ['0.0', '100.0', '200.0', '300.0'];
  List<String> paceOptions = ['4.0', '5.0', '6.0', '7.0', '8.0', '10'];
  List<String> timeOptions = [
    '10',
    '20',
    '30',
    '40',
    '60',
    '90',
    '120',
    '180',
    '300'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).appName),
        ),
        bottomSheet: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom),
            color: Theme.of(context).colorScheme.background,
            child: DraggableScrollableSheet(
                minChildSize: 0.32,
                expand: false,
                snap: true,
                // snapSizes: const [0.4],
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text('初始海拔'),
                                      DropdownButton<String>(
                                        value: initialAltitude,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            initialAltitude = newValue!;
                                          });
                                          regerator();
                                        },
                                        items: altitudeOptions
                                            .map<DropdownMenuItem<String>>(
                                          (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                      const SizedBox(height: 16.0),
                                      const Text('最小配速'),
                                      DropdownButton<String>(
                                        value: minPace,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            minPace = newValue!;
                                          });
                                          regerator();
                                        },
                                        items: paceOptions
                                            .map<DropdownMenuItem<String>>(
                                          (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                      const SizedBox(height: 16.0),
                                      const Text('平均配速'),
                                      DropdownButton<String>(
                                        value: averagePace,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            averagePace = newValue!;
                                          });
                                          regerator();
                                        },
                                        items: paceOptions
                                            .map<DropdownMenuItem<String>>(
                                          (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text('结束海拔'),
                                      DropdownButton<String>(
                                        value: finalAltitude,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            finalAltitude = newValue!;
                                          });
                                          regerator();
                                        },
                                        items: altitudeOptions
                                            .map<DropdownMenuItem<String>>(
                                          (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                      const SizedBox(height: 16.0),
                                      const Text('最大配速'),
                                      DropdownButton<String>(
                                        value: maxPace,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            maxPace = newValue!;
                                          });
                                          regerator();
                                        },
                                        items: paceOptions
                                            .map<DropdownMenuItem<String>>(
                                          (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                      const SizedBox(height: 16.0),
                                      const Text('运动时长'),
                                      DropdownButton<String>(
                                        value: timeDuration,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            timeDuration = newValue!;
                                          });
                                          regerator();
                                        },
                                        items: timeOptions
                                            .map<DropdownMenuItem<String>>(
                                          (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
                })),
        body: SizedBox.expand(
            child: Stack(
          children: [
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   right: 0,
            //   child: AspectRatio(
            //     aspectRatio: 1,
            //     child: TrajectoryPanel(
            //       onAxisShow: (show) {
            //         setState(() {
            //           isAxisShow = show;
            //         });
            //       },
            //       trackStat: widget.trackStat,
            //     ),
            //   ),
            // ),
            if (isAxisShow)
              const Positioned(top: 0, right: 0, child: ColorLabels()),
            Text(
              'initialAltitude: ${initialAltitude}, finalAltitude: ${finalAltitude}, minPace: ${minPace}, maxPace: ${maxPace}, averagePace: ${averagePace}, timeDuration: ${timeDuration}',
            ),
          ],
        )));
  }

  void regerator() {
    TrackGenerator generator = TrackGenerator(
      initialAltitude: double.parse(initialAltitude),
      finalAltitude: double.parse(finalAltitude),
      maxPace: double.parse(maxPace),
      minPace: double.parse(minPace),
      averagePace: double.parse(minPace),
      timeDuration: double.parse(timeDuration),
    );
    generator.generateTrack();
  }
}
