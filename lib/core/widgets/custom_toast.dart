import 'dart:async';

import 'package:alphatwelve/core/icons/app_icons.dart';
import 'package:alphatwelve/core/icons/custom_icon.dart';
import 'package:alphatwelve/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
// TODO: Re-evaluate default values - Currently hard-coded for a success scenario.

// class CustomToast {
//   static OverlayEntry? _overlayEntry;
//   static Timer? _timer;
//   static bool _isVisible = false;
//
//   static void show({
//     required BuildContext context,
//     required String message,
//     Duration duration = const Duration(seconds: 3),
//     Color backgroundColor = Colors.white,
//     Color textColor = AppColor.gray700,
//     double textSize = 14.0,
//     double padding = 16.0,
//     double radius = 8.0,
//     bool tapToDismiss = true,
//     Widget? icon,
//     TextAlign textAlign = TextAlign.center,
//   }) {
//     // If toast is already visible, dismiss it first
//     if (_isVisible) {
//       dismiss();
//     }
//
//     _isVisible = true;
//
//     // Create overlay entry
//     _overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         // bottom: margin.bottom,
//         top: 50,
//         left: 16,
//         right: 16,
//         child: Material(
//           color: Colors.transparent,
//           child: GestureDetector(
//             onTap: tapToDismiss ? () => dismiss() : null,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppColor.success500,
//                 borderRadius: BorderRadius.circular(radius),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.05),
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Container(
//                 padding: EdgeInsets.all(padding),
//                 margin: const EdgeInsets.only(left: 4),
//                 decoration: BoxDecoration(
//                   color: backgroundColor,
//                   borderRadius: BorderRadius.circular(radius),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const CustomIcon(assetPath: AppIcons.check),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Text(
//                         message,
//                         textAlign: textAlign,
//                         style: TextStyle(
//                           color: textColor,
//                           fontSize: textSize,
//                           height: 1.5,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     GestureDetector(
//                       onTap: dismiss,
//                       child: const CustomIcon(
//                         assetPath: AppIcons.close,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//
//     // Insert overlay
//     Overlay.of(context).insert(_overlayEntry!);
//
//     // Start timer to dismiss toast
//     _timer = Timer(duration, dismiss);
//   }
//
//   static void dismiss() {
//     if (!_isVisible) return;
//
//     _timer?.cancel();
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//     _isVisible = false;
//   }
// }

class CustomToast {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;
  static bool _isVisible = false;

  static void show({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.white,
    Color textColor = AppColor.gray700,
    double textSize = 14.0,
    double padding = 16.0,
    double radius = 8.0,
    bool tapToDismiss = true,
    Widget? icon,
    EdgeInsets margin = const EdgeInsets.all(20),
    TextAlign textAlign = TextAlign.center,
    ToastPosition position = ToastPosition.bottom,
    Curve animationCurve = Curves.easeOut,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    if (_isVisible) {
      dismiss();
    }

    _isVisible = true;

    final overlayState = Overlay.of(context);

    final controller = AnimationController(
      vsync: overlayState,
      duration: animationDuration,
    );
    final opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: animationCurve),
    );
    final offsetAnimation = Tween<Offset>(
      begin: position == ToastPosition.bottom
          ? const Offset(0, 0.5)
          : const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: animationCurve));

    controller.forward();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position == ToastPosition.top ? margin.top : null,
        bottom: position == ToastPosition.bottom ? margin.bottom : null,
        left: margin.left,
        right: margin.right,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Opacity(
              opacity: opacityAnimation.value,
              child: Transform.translate(
                offset: offsetAnimation.value * 20,
                child: Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: tapToDismiss ? () => dismiss() : null,
                    child: Container(
                      padding: EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(radius),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (icon != null) ...[
                            icon,
                            const SizedBox(width: 8),
                          ],
                          Expanded(
                            child: Text(
                              message,
                              textAlign: textAlign,
                              style: TextStyle(
                                color: textColor,
                                fontSize: textSize,
                                height: 1.4,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: dismiss,
                            child: const CustomIcon(assetPath: AppIcons.close),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);

    _timer = Timer(duration, () {
      controller.reverse().then((_) {
        dismiss();
      });
    });
  }

  static void dismiss() {
    if (!_isVisible) return;
    _timer?.cancel();
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isVisible = false;
  }
}

enum ToastPosition {
  top,
  bottom,
}
