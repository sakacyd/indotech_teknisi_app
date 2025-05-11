import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  const CustomStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    double progress;
    if (currentStep == 0) {
      progress = 0.0;
    } else if (currentStep == 1) {
      progress = 0.33;
    } else if (currentStep == 2) {
      progress = 0.66;
    } else if (currentStep == 3) {
      progress = 1.0;
    } else {
      progress = 0.0;
    }
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyStepper(
                  alignment: Alignment.center,
                  fitWidth: true,
                  activeStep: currentStep,
                  lineStyle: LineStyle(
                    lineLength: screenWidth * 0.13,
                    lineThickness: 6,
                    lineSpace: 5,
                    lineType: LineType.normal,
                    defaultLineColor: Colors.purple.shade300,
                    progress: progress,
                  ),
                  borderThickness: 5,
                  internalPadding: 20,
                  loadingAnimation: 'assets/loading_white.json',
                  steps: const [
                    EasyStep(
                      icon: Icon(Icons.add_road),
                      title: 'Cart',
                      lineText: 'Add Address Info',
                    ),
                    EasyStep(
                      icon: Icon(Icons.location_city),
                      title: 'Address',
                      lineText: 'Go To Checkout',
                    ),
                    EasyStep(
                      icon: Icon(Icons.share_arrival_time_rounded),
                      title: 'Checkout',
                      lineText: 'Choose Payment Method',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
