import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indotech_teknisi_app/features/dashboard/presentation/widgets/details/bloc/stepper_bloc.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper({super.key});

  @override
  Widget build(BuildContext context) {
    double progress = 0.2;
    return BlocBuilder<StepperBloc, StepperState>(
      builder: (context, state) {
        int currentStep = 0;
        if (state is StepperChanged) {
          currentStep = state.currentStep;
        }

        return Column(
          children: [
            EasyStepper(
              activeStep: currentStep,
              lineStyle: LineStyle(
                lineLength: 100,
                lineThickness: 6,
                lineSpace: 4,
                lineType: LineType.normal,
                defaultLineColor: Colors.purple.shade300,
                progress: progress,
              ),
              borderThickness: 10,
              internalPadding: 15,
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
                EasyStep(
                  icon: Icon(Icons.attach_money),
                  title: 'Payment',
                  lineText: 'Confirm Order Items',
                ),
                EasyStep(
                  icon: Icon(Icons.file_present_rounded),
                  title: 'Order Details',
                  lineText: 'Submit Order',
                ),
                EasyStep(
                  icon: Icon(Icons.check_circle_outline),
                  title: 'Finish',
                ),
              ],
              onStepReached: (index) {
                context.read<StepperBloc>().add(ChangeStep(index));
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
