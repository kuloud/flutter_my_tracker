// import 'dart:async';
// import 'dart:io' show Platform;

// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';

// class GeoLocatorPage extends StatefulWidget {
//   /// Creates a new GeolocatorWidget.
//   const GeoLocatorPage({Key? key}) : super(key: key);

//   @override
//   _GeoLocatorPageState createState() => _GeoLocatorPageState();
// }

// class _GeoLocatorPageState extends State<GeoLocatorPage> {
//   static const String _kLocationServicesDisabledMessage =
//       'Location services are disabled.';
//   static const String _kPermissionDeniedMessage = 'Permission denied.';
//   static const String _kPermissionDeniedForeverMessage =
//       'Permission denied forever.';
//   static const String _kPermissionGrantedMessage = 'Permission granted.';

//   final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
//   final List<_PositionItem> _positionItems = <_PositionItem>[];
//   StreamSubscription<Position>? _positionStreamSubscription;
//   StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
//   bool positionStreamStarted = false;

//   @override
//   void initState() {
//     super.initState();
//     _toggleServiceStatusStream();
//   }

//   PopupMenuButton _createActions() {
//     return PopupMenuButton(
//       elevation: 40,
//       onSelected: (value) async {
//         switch (value) {
//           case 1:
//             _getLocationAccuracy();
//             break;
//           case 2:
//             _requestTemporaryFullAccuracy();
//             break;
//           case 3:
//             _openAppSettings();
//             break;
//           case 4:
//             _openLocationSettings();
//             break;
//           case 5:
//             setState(_positionItems.clear);
//             break;
//           default:
//             break;
//         }
//       },
//       itemBuilder: (context) => [
//         if (Platform.isIOS)
//           const PopupMenuItem(
//             value: 1,
//             child: Text("Get Location Accuracy"),
//           ),
//         if (Platform.isIOS)
//           const PopupMenuItem(
//             value: 2,
//             child: Text("Request Temporary Full Accuracy"),
//           ),
//         const PopupMenuItem(
//           value: 3,
//           child: Text("Open App Settings"),
//         ),
//         if (Platform.isAndroid || Platform.isWindows)
//           const PopupMenuItem(
//             value: 4,
//             child: Text("Open Location Settings"),
//           ),
//         const PopupMenuItem(
//           value: 5,
//           child: Text("Clear"),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     const sizedBox = SizedBox(
//       height: 10,
//     );

//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: ListView.builder(
//         itemCount: _positionItems.length,
//         itemBuilder: (context, index) {
//           final positionItem = _positionItems[index];

//           if (positionItem.type == _PositionItemType.log) {
//             return ListTile(
//               title: Text(positionItem.displayValue,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     // color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   )),
//             );
//           } else {
//             return Card(
//               child: ListTile(
//                 title: Text(
//                   positionItem.displayValue,
//                   style: const TextStyle(
//                       // color: Colors.white
//                       ),
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//       floatingActionButton: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: () {
//               positionStreamStarted = !positionStreamStarted;
//               _toggleListening();
//             },
//             tooltip: (_positionStreamSubscription == null)
//                 ? 'Start position updates'
//                 : _positionStreamSubscription!.isPaused
//                     ? 'Resume'
//                     : 'Pause',
//             backgroundColor: _determineButtonColor(),
//             child: (_positionStreamSubscription == null ||
//                     _positionStreamSubscription!.isPaused)
//                 ? const Icon(Icons.play_arrow)
//                 : const Icon(Icons.pause),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handlePermission();

//     if (!hasPermission) {
//       return;
//     }

//     final position = await _geolocatorPlatform.getCurrentPosition();
//     _updatePositionList(
//       _PositionItemType.position,
//       position.toString(),
//     );
//   }

//   Future<bool> _handlePermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       _updatePositionList(
//         _PositionItemType.log,
//         _kLocationServicesDisabledMessage,
//       );

//       return false;
//     }

//     permission = await _geolocatorPlatform.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await _geolocatorPlatform.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         _updatePositionList(
//           _PositionItemType.log,
//           _kPermissionDeniedMessage,
//         );

//         return false;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       _updatePositionList(
//         _PositionItemType.log,
//         _kPermissionDeniedForeverMessage,
//       );

//       return false;
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     _updatePositionList(
//       _PositionItemType.log,
//       _kPermissionGrantedMessage,
//     );
//     return true;
//   }

//   void _updatePositionList(_PositionItemType type, String displayValue) {
//     _positionItems.add(_PositionItem(type, displayValue));
//     print(displayValue);
//     setState(() {});
//   }

//   bool _isListening() => !(_positionStreamSubscription == null ||
//       _positionStreamSubscription!.isPaused);

//   Color _determineButtonColor() {
//     return _isListening() ? Colors.green : Colors.red;
//   }

//   void _toggleServiceStatusStream() {
//     if (_serviceStatusStreamSubscription == null) {
//       final serviceStatusStream = _geolocatorPlatform.getServiceStatusStream();
//       _serviceStatusStreamSubscription =
//           serviceStatusStream.handleError((error) {
//         _serviceStatusStreamSubscription?.cancel();
//         _serviceStatusStreamSubscription = null;
//       }).listen((serviceStatus) {
//         String serviceStatusValue;
//         if (serviceStatus == ServiceStatus.enabled) {
//           if (positionStreamStarted) {
//             _toggleListening();
//           }
//           serviceStatusValue = 'enabled';
//         } else {
//           if (_positionStreamSubscription != null) {
//             setState(() {
//               _positionStreamSubscription?.cancel();
//               _positionStreamSubscription = null;
//               _updatePositionList(
//                   _PositionItemType.log, 'Position Stream has been canceled');
//             });
//           }
//           serviceStatusValue = 'disabled';
//         }
//         _updatePositionList(
//           _PositionItemType.log,
//           'Location service has been $serviceStatusValue',
//         );
//       });
//     }
//   }

//   void _toggleListening() {
//     if (_positionStreamSubscription == null) {
//       final positionStream = _geolocatorPlatform.getPositionStream();
//       _positionStreamSubscription = positionStream.handleError((error) {
//         _positionStreamSubscription?.cancel();
//         _positionStreamSubscription = null;
//       }).listen((position) => _updatePositionList(
//             _PositionItemType.position,
//             position.toString(),
//           ));
//       _positionStreamSubscription?.pause();
//     }

//     setState(() {
//       if (_positionStreamSubscription == null) {
//         return;
//       }

//       String statusDisplayValue;
//       if (_positionStreamSubscription!.isPaused) {
//         _positionStreamSubscription!.resume();
//         statusDisplayValue = 'resumed';
//       } else {
//         _positionStreamSubscription!.pause();
//         statusDisplayValue = 'paused';
//       }

//       _updatePositionList(
//         _PositionItemType.log,
//         'Listening for position updates $statusDisplayValue',
//       );
//     });
//   }

//   @override
//   void dispose() {
//     if (_positionStreamSubscription != null) {
//       _positionStreamSubscription!.cancel();
//       _positionStreamSubscription = null;
//     }

//     super.dispose();
//   }

//   void _getLastKnownPosition() async {
//     final position = await _geolocatorPlatform.getLastKnownPosition();
//     if (position != null) {
//       _updatePositionList(
//         _PositionItemType.position,
//         position.toString(),
//       );
//     } else {
//       _updatePositionList(
//         _PositionItemType.log,
//         'No last known position available',
//       );
//     }
//   }

//   void _getLocationAccuracy() async {
//     final status = await _geolocatorPlatform.getLocationAccuracy();
//     _handleLocationAccuracyStatus(status);
//   }

//   void _requestTemporaryFullAccuracy() async {
//     final status = await _geolocatorPlatform.requestTemporaryFullAccuracy(
//       purposeKey: "TemporaryPreciseAccuracy",
//     );
//     _handleLocationAccuracyStatus(status);
//   }

//   void _handleLocationAccuracyStatus(LocationAccuracyStatus status) {
//     String locationAccuracyStatusValue;
//     if (status == LocationAccuracyStatus.precise) {
//       locationAccuracyStatusValue = 'Precise';
//     } else if (status == LocationAccuracyStatus.reduced) {
//       locationAccuracyStatusValue = 'Reduced';
//     } else {
//       locationAccuracyStatusValue = 'Unknown';
//     }
//     _updatePositionList(
//       _PositionItemType.log,
//       '$locationAccuracyStatusValue location accuracy granted.',
//     );
//   }

//   void _openAppSettings() async {
//     final opened = await _geolocatorPlatform.openAppSettings();
//     String displayValue;

//     if (opened) {
//       displayValue = 'Opened Application Settings.';
//     } else {
//       displayValue = 'Error opening Application Settings.';
//     }

//     _updatePositionList(
//       _PositionItemType.log,
//       displayValue,
//     );
//   }

//   void _openLocationSettings() async {
//     final opened = await _geolocatorPlatform.openLocationSettings();
//     String displayValue;

//     if (opened) {
//       displayValue = 'Opened Location Settings';
//     } else {
//       displayValue = 'Error opening Location Settings';
//     }

//     _updatePositionList(
//       _PositionItemType.log,
//       displayValue,
//     );
//   }
// }

// enum _PositionItemType {
//   log,
//   position,
// }

// class _PositionItem {
//   _PositionItem(this.type, this.displayValue);

//   final _PositionItemType type;
//   final String displayValue;
// }
