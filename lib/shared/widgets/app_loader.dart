import 'package:flutter/material.dart';
import 'package:machinetest/shared/utils/app_colors.dart';

enum AppLoaderType { fullscreen, overlay }

class AppLoader {
  bool _isShowing = false;

  show(
    BuildContext context, {
    AppLoaderType type = AppLoaderType.overlay,
    String? message,
    Key? key,
    bool isDismissible = false,
    bool createNew = true,
  }) {
    if (!createNew && _isShowing) {
      return;
    }
    hide(context); // Hide any existing loader
    _isShowing = true;

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: isDismissible,
      builder: (_) {
        return WillPopScope(
          onWillPop: () => Future.value(isDismissible),
          child: AppOverlayLoader(
            key: key,
          ),
        );
      },
    );

    // Automatically hide the loader after 5 seconds
    Future.delayed(const Duration(seconds: 30), () {
      hide(context);
    });
  }

  hide(BuildContext context, {String? message, Key? key}) {
    if (_isShowing) {
      _isShowing = false;
      Navigator.of(context).pop();
    }
  }
}

class AppOverlayLoader extends StatelessWidget {
  final Widget? widget;
  final double? loaderWidth, loaderHeight;

  const AppOverlayLoader({
    Key? key,
    this.widget,
    this.loaderHeight,
    this.loaderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: widget ??
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(
                      color: AppColors.themeColor,
                      strokeWidth: .5,
                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }
}
