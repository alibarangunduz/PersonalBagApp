import 'package:flutter/material.dart';
import 'package:torch_compat/torch_compat.dart';

//https://pub.dev/packages/torch_compat/example

class FlashLight extends StatefulWidget {
  @override
  _FlashLightState createState() => _FlashLightState();
}

class _FlashLightState extends State<FlashLight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flash Light'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                  child: Text('Turn on'),
                  onPressed: () {
                    TorchCompat.turnOn();
                  }),
              RaisedButton(
                  child: Text('Turn off'),
                  onPressed: () {
                    TorchCompat.turnOff();
                  })
            ],
          ),
        ),
      );
  }

  @override
  void dispose() {
    // Mandatory for Camera 1 on Android
    TorchCompat.dispose();
    super.dispose();
  }
}