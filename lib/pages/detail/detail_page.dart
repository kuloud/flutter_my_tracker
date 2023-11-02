import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'dart:ui' as ui show PictureRecorder, ImageByteFormat, Image;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/pages/detail/components/main_info_card.dart';
import 'package:flutter_my_tracker/pages/detail/components/trajectory/color_label.dart';
import 'package:flutter_my_tracker/pages/detail/components/trajectory/trajectory_panel.dart';
import 'package:flutter_my_tracker/providers/location_provider.dart';
import 'package:flutter_my_tracker/stat/chart/line_chart_altitude.dart';
import 'package:flutter_my_tracker/stat/chart/chart_pace.dart';
import 'package:flutter_my_tracker/stat/track_stat.dart';
import 'package:flutter_my_tracker/utils/logger.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.trackStat});

  final TrackStat trackStat;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  GlobalKey _globalKeyTrajectory = GlobalKey();
  GlobalKey _globalKeyBottomSheet = GlobalKey();
  Future<List<Position>?>? _fetchTrackPoints;
  bool isAxisShow = false;

  @override
  void initState() {
    super.initState();
    _fetchTrackPoints = PositionProvider.instance().getAllPositions(
        startTime: DateTime.fromMillisecondsSinceEpoch(
            widget.trackStat.startTime.toInt()),
        endTime: DateTime.fromMillisecondsSinceEpoch(
            widget.trackStat.endTime.toInt()));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _captureAndShareScreenshot([Color? backgroundColor]) async {
    try {
      Uint8List? trajectoryImage =
          await _captureScreenshot(_globalKeyTrajectory.currentContext!);
      Uint8List? bottomSheetImage =
          await _captureScreenshot(_globalKeyBottomSheet.currentContext!);

      Uint8List byteData = await mergeImages(
          trajectoryImage!, bottomSheetImage!, backgroundColor);
      final directory = (await getTemporaryDirectory()).path;
      final imagePath = '$directory/screenshot.png';

      File(imagePath).writeAsBytesSync(byteData.buffer.asUint8List());

      await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());

      Share.shareFiles(
        [imagePath],
        text: '分享截图',
      );
    } catch (e) {
      logger.e('[_captureAndShareScreenshot]', error: e);
    }
  }

  Future<Uint8List?> _captureScreenshot(BuildContext context) async {
    try {
      RenderRepaintBoundary boundary =
          context.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      logger.w(e.toString());
    }
    return null;
  }

  Future<Uint8List> mergeImages(Uint8List image1, Uint8List image2,
      [Color? backgroundColor]) async {
    ui.Image img1 = await decodeImageFromList(image1);
    ui.Image img2 = await decodeImageFromList(image2);

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    if (backgroundColor != null) {
      canvas.drawColor(backgroundColor, BlendMode.color);
    }

    canvas.drawImage(img1, Offset.zero, Paint());
    canvas.drawImage(img2, Offset(0, img1.width.toDouble()), Paint());

    final picture = recorder.endRecording();
    final mergedImage = await picture.toImage(
      (max(img1.width, img2.width)),
      img1.width + img2.height,
    );
    final byteData =
        await mergedImage.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).appName),
          actions: [
            IconButton(
                onPressed: () {
                  final backgroundColor =
                      Theme.of(context).colorScheme.background;
                  _captureAndShareScreenshot(backgroundColor);
                },
                icon: const Icon(Icons.share))
          ],
        ),
        bottomSheet: Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom),
          color: Theme.of(context).colorScheme.background,
          child: DraggableScrollableSheet(
            // maxChildSize: 0.6,
            // minChildSize: 0.4,
            minChildSize: 0.32,
            expand: false,
            snap: true,
            // snapSizes: const [0.4],
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: RepaintBoundary(
                  key: _globalKeyBottomSheet,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MainInfoCard(
                          trackStat: widget.trackStat,
                        ),
                        FutureBuilder(
                            future: _fetchTrackPoints,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    ChartPace(
                                        trackStat: widget.trackStat,
                                        points: snapshot.data!),
                                    LineChartAltitude(
                                        trackStat: widget.trackStat,
                                        points: snapshot.data!)
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            })
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        body: RepaintBoundary(
          key: _globalKeyTrajectory,
          child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: TrajectoryPanel(
                        onAxisShow: (show) {
                          setState(() {
                            isAxisShow = show;
                          });
                        },
                        trackStat: widget.trackStat,
                      ),
                    ),
                  ),
                  if (isAxisShow)
                    const Positioned(top: 0, right: 0, child: ColorLabels()),
                ],
              )),
        ));
  }
}
