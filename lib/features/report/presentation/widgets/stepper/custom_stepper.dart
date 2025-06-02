import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  const CustomStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
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
                    defaultLineColor: Colors.blue,
                    progressColor: Colors.blue.shade800,
                    finishedLineColor: Colors.blue.shade800,
                    progress: 0.0,
                  ),
                  borderThickness: 5,
                  internalPadding: 20,
                  loadingAnimation: 'assets/loading_white.json',
                  steps: const [
                    EasyStep(
                      icon: Icon(Icons.shopping_cart),
                      title: 'Cart',
                      lineText: 'Add Address Info',
                    ),
                    EasyStep(
                      icon: Icon(Icons.info),
                      title: 'Address',
                      lineText: 'Go To Checkout',
                    ),
                    EasyStep(
                      icon: Icon(Icons.shopping_cart_outlined),
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
