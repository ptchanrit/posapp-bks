import 'package:flutter/material.dart';

class RedColorStepper extends StatefulWidget {
  const RedColorStepper({super.key});

  @override
  State<RedColorStepper> createState() => _RedColorStepperState();
}

class _RedColorStepperState extends State<RedColorStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Red Color Stepper'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          setState(() {
            _currentStep < 2 ? _currentStep += 1 : null;
          });
        },
        onStepCancel: () {
          setState(() {
            _currentStep > 0 ? _currentStep -= 1 : null;
          });
        },
        steps: [
          Step(
            title: const Text('Step 1'),
            content: Container(
              alignment: Alignment.centerLeft,
              child :const Text('This is step 1 content.'),
              
            ),
            isActive: _currentStep == 0,
            state: _currentStep == 0 ? StepState.editing : StepState.indexed,
          ),
          Step(
            title: const Text('Step 2'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('This is step 2 content.'),
            ),
            isActive: _currentStep == 1,
            state: _currentStep == 1 ? StepState.editing : StepState.indexed,
          ),
          Step(
            title:const Text('Step 3'),
            content: Container(
              alignment: Alignment.centerLeft,
              child:const Text('This is step 3 content.'),
            ),
            isActive: _currentStep == 2,
            state: _currentStep == 2 ? StepState.editing : StepState.indexed,
          ),
        ],
      ),
    );
  }
}
