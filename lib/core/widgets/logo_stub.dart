import 'package:alphatwelve/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LogoStub extends StatelessWidget {
  const LogoStub({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 28,
        width: 70,
        margin: const EdgeInsets.only(left: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: AppColor.brand300,
          border: Border.all(
            color: AppColor.brand600,
            width: 0.88,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: const Center(
          child: Text(
            'Full Logo',
            style: TextStyle(
              color: AppColor.brand600,
              fontSize: 10.5,
              height: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
