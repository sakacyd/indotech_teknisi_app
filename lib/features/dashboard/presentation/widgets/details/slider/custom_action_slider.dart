import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';

class CustomActionSlider extends StatelessWidget {
  final String text;
  final VoidCallback onSuccess;
  const CustomActionSlider({
    super.key,
    required this.text,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ActionSlider.standard(
        action: (controller) async {
          controller.loading();
          await Future.delayed(const Duration(milliseconds: 500));
          controller.success();
          onSuccess();
          await Future.delayed(const Duration(milliseconds: 500));
          controller.reset();
          controller.dispose();
        },
        child: Text(text),
      ),
    );
  }
}
