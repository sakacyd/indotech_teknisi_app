import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';

class CustomActionSlider extends StatelessWidget {
  final String text;
  const CustomActionSlider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ActionSlider.standard(
      action: (controller) async {
        controller.loading();
        await Future.delayed(const Duration(milliseconds: 500));
        controller.success();
        await Future.delayed(const Duration(milliseconds: 500));
        controller.reset();
      },
      child: Text(text),
    );
  }
}
