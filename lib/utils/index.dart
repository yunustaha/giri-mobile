import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'mobimColors.dart';

enum ToastMessageType { ERROR, SUCCESS, WARNING }

mixin MobimWidgetFunctions {
  void onLoading(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: const Center(child: CircularProgressIndicator()));
      },
    );
  }

  final fToast = FToast();
  //Toast message context olmadan da kullanilabilir "fluttertoast" paketine pub.dev'den bakılabilir.
  //Burada icon gostermek amaci ile context kullanilmistir.

  Color _toastMessageTypeColor(ToastMessageType type) {
    switch (type) {
      case ToastMessageType.SUCCESS:
        return MobimColors.success;
      case ToastMessageType.WARNING:
        return MobimColors.warning;
      case ToastMessageType.ERROR:
        return MobimColors.error;
      default:
        return Colors.blue;
    }
  }

  IconData? _toastMessageTypeIcon(ToastMessageType type) {
    switch (type) {
      case ToastMessageType.SUCCESS:
        return Icons.done;
      case ToastMessageType.WARNING:
        return Icons.warning;
      case ToastMessageType.ERROR:
        return Icons.error;
      default:
        return null;
    }
  }

  void toastMessage({required BuildContext context, required ToastMessageType type, required String message}) => {
        fToast.init(context),
        fToast.showToast(
          gravity: ToastGravity.BOTTOM,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            margin: const EdgeInsets.only(bottom: 80),
            decoration: BoxDecoration(
              color: _toastMessageTypeColor(type),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(_toastMessageTypeIcon(type),
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        )
      };
}