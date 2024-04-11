import 'dart:async';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:giri/screens/Home/index.dart';
import 'package:giri/utils/index.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:system_alert_window/system_alert_window.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> with GiriMixin {
  SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;
  static const String _mainAppPort = 'MainApp';
  final _receivePort = ReceivePort();
  SendPort? homePort;
  String? latestMessageFromOverlay;

  Future<bool> requestPermission() async {
    await SystemAlertWindow.requestPermissions(prefMode: prefMode);
    PermissionStatus status = await Permission.phone.request();

    return switch (status) {
      PermissionStatus.denied || PermissionStatus.restricted || PermissionStatus.limited || PermissionStatus.permanentlyDenied => false,
      PermissionStatus.provisional || PermissionStatus.granted => true,
    };
  }

  void overlayEventListener() async {
    if (homePort != null) return;
    final res = IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      _mainAppPort,
    );
    log("$res: OVERLAY");
    _receivePort.listen((message) {
      log("message from OVERLAY: $message");
      openBottomSheet(context, const Placeholder());
      SystemChannels.platform.invokeMethod('activate');
    });
  }

  @override
  void initState() {
    super.initState();

    overlayEventListener();

    requestPermission().then(
      (value) => {
        if (value)
          {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              PhoneState.stream.listen((event) {
                if (event.status == PhoneStateStatus.CALL_INCOMING || event.status == PhoneStateStatus.CALL_STARTED) {
                  if (event.number != null) {
                    log('Number: ${event.number}');
                    _showOverlayWindow();
                  }
                }
              });
            })
          }
      },
    );
  }

  @override
  void dispose() {
    // SystemAlertWindow.removeOnClickListener();
    log('dispose');
    super.dispose();
  }

  void _showOverlayWindow() async {
    SystemAlertWindow.sendMessageToOverlay('show system window').then(
      (value) => {
        SystemAlertWindow.showSystemWindow(
          height: 200,
          width: MediaQuery.of(context).size.width.floor(),
          gravity: SystemWindowGravity.CENTER,
          prefMode: prefMode,
        )
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
