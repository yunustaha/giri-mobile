import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:giri/utils/colors.dart';

enum ToastMessageType { error, success, warning }

mixin GiriMixin {
  void onLoading(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const PopScope(canPop: false, child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  final fToast = FToast();
  //Toast message context olmadan da kullanilabilir "fluttertoast" paketine pub.dev'den bakılabilir.
  //Burada icon gostermek amaci ile context kullanilmistir.

  Color _toastMessageTypeColor(ToastMessageType type) {
    switch (type) {
      case ToastMessageType.success:
        return GiriColors.success;
      case ToastMessageType.warning:
        return GiriColors.warning;
      case ToastMessageType.error:
        return GiriColors.error;
      default:
        return Colors.blue;
    }
  }

  IconData? _toastMessageTypeIcon(ToastMessageType type) {
    switch (type) {
      case ToastMessageType.success:
        return Icons.done;
      case ToastMessageType.warning:
        return Icons.warning;
      case ToastMessageType.error:
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
                Icon(
                  _toastMessageTypeIcon(type),
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
