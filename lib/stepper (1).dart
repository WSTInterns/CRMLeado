import 'package:flutter/material.dart';
import 'package:another_stepper/another_stepper.dart';

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    return AnotherStepper(
      stepperList: stepperData,
      stepperDirection: Axis.vertical,
      iconWidth: 40, // Height that will be applied to all the stepper icons
      iconHeight: 40, // Width that will be applied to all the stepper icons
      verticalGap: 20,
    );
  }

  List<StepperData> stepperData = [
    StepperData(
      title: StepperText(
        "Order Placed",
        textStyle: const TextStyle(
          fontFamily: "Montserrat",
          color: Colors.grey,
        ),
      ),
      subtitle: StepperText("Your order has been placed",
          textStyle: TextStyle(
            fontFamily: "Montserrat",
          )),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: const Icon(Icons.looks_one, color: Colors.white),
      ),
    ),
  ];
  //     Column(
  //       children: [
  //         Expanded(
  //           child: Stepper(
  //             controlsBuilder: (context, details) {
  //               return Container();
  //             },
  //             type: stepperType,
  //             physics: const ScrollPhysics(),
  //             // currentStep: _currentStep,
  //             // onStepTapped: (step) => tapped(step),
  //             onStepContinue: null,
  //             onStepCancel: null,
  //             steps: <Step>[
  //               step('1' ),
  //               step('2' ),
  //               step('3' ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Step step(title) {
  //   return Step(
  //     title:  Text(title),
  //     content: Column(
  //       children: <Widget>[
  //         TextFormField(
  //           decoration: const InputDecoration(labelText: 'Mobile Number'),
  //         ),
  //       ],
  //     ),
  //     isActive: true,
  //     // state: _currentStep >= 2
  //     //     ? StepState.complete
  //     //     : StepState.disabled,
  //   );
  // }

  // tapped(int step) {
  //   setState(() => _currentStep = step);
  // }

  // continued() {
  //   _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  // }

  // cancel() {
  //   _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  // }
}
