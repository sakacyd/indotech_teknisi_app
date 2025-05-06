import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/widgets/details/bloc/stepper_bloc.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper({super.key});

  @override
  Widget build(BuildContext context) {
    double progress = 0.2;
    final double screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<StepperBloc, StepperState>(
      builder: (context, state) {
        int currentStep = 0;
        if (state is StepperChanged) {
          currentStep = state.currentStep;
        }

        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EasyStepper(
                      activeStep: currentStep,
                      lineStyle: LineStyle(
                        lineLength: screenWidth * 0.13, // atau nilai konstan
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
                      onStepReached: (index) {
                        context.read<StepperBloc>().add(ChangeStep(index));
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
