import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as ctx;
import 'package:go_router/go_router.dart';
import 'package:unggul_mobile/core/util/util.dart';

extension ContextDialog on ctx.BuildContext {
  String get path => GoRouterState.of(this).fullPath ?? '';
  TextTheme get textStyle => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;

  void loading(bool value) {
    if (value) {
      showDialog(
        context: this,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (context) => Center(
          child: Container(
            color: Colors.white,
            width: 90,
            height: 90,
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      pop();
    }
  }

  void snackbarError(ErrorEntity? error) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(error?.getMsg ?? ''),
        backgroundColor: colors.error,
      ),
    );
  }

  void snackbarSuccess(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  void popupDelete({String? title, Function? onNext, Function? onCancel}) {
    showAdaptiveDialog(
      context: this,
      builder: (context) => AlertDialog.adaptive(
        title: Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus ${title ?? 'data'}?'),
        actions: [
          TextButton(
            onPressed: () {
              pop();
              if (onNext != null) onNext();
            },
            child: Text('Ya'),
          ),
          TextButton(
            onPressed: () {
              pop();
              if (onCancel != null) onCancel();
            },
            child: Text('Tidak'),
          ),
        ],
      ),
    );
  }
}
