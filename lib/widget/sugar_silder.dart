import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SugarSilder extends StatefulWidget {
  const SugarSilder({super.key});

  @override
  State<SugarSilder> createState() => _SugarSliderState();
}

class _SugarSliderState extends State<SugarSilder> {
  double _value = 100.0;

  @override
  Widget build(BuildContext context) {
    return 

    SfSlider.vertical(
      min: 0.0,
      max: 150.0,
      interval: 25,
      showLabels: true,
      showTicks: true,
      value: _value,
      enableTooltip: true,


      onChanged: (dynamic value) {
        final roundedValue = (value / 25).round() * 25;
        setState(() {
          _value = roundedValue.toDouble();
        });
      },
    );
  }
}
