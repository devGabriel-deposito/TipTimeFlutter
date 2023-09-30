import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hora da Gorjeta",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const TipTime(),
    );
  }
}

class TipTime extends StatefulWidget {
  const TipTime({super.key});

  @override
  State<TipTime> createState() => _TipTimeState();
}

class _TipTimeState extends State<TipTime> {
  double tipValue = 0.0;

  TextEditingController valueController = TextEditingController();
  TextEditingController percentController = TextEditingController();
  bool roundValue = false;

  void calculateTip() {
    double value = double.tryParse(valueController.text) ?? 0.0;
    double percent = double.tryParse(percentController.text) ?? 15.0;

    double calculatedValue = value * (percent / 100);
    calculatedValue =
        double.tryParse(calculatedValue.toStringAsFixed(2)) ?? 0.0;

    if (roundValue) {
      calculatedValue = calculatedValue.ceilToDouble();
    }

    setState(() {
      tipValue = calculatedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hora da Gorjeta"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: [
            TextField(
              controller: valueController,
              onChanged: (value) {
                calculateTip();
              },
              decoration: const InputDecoration(
                labelText: "Valor",
                icon: Icon(Icons.monetization_on_rounded),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: percentController,
              onChanged: (value) {
                calculateTip();
              },
              decoration: const InputDecoration(
                labelText: "Porcentagem",
                icon: Icon(Icons.percent_rounded),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Row(
              children: [
                // ElevatedButton(
                //   onPressed: () => calculateTip(),
                //   child: const Text("Calcular"),
                // ),
                const Spacer(flex: 1),
                Column(
                  children: [
                    const Text("Arredondar?"),
                    Switch(
                      value: roundValue,
                      onChanged: (bool value) {
                        setState(() {
                          roundValue = value;
                          calculateTip();
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 80.0),
            ),
            Text(
              "Gorjeta: R\$ ${tipValue}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
