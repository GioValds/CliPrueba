import 'package:flutter/material.dart';
import 'package:testing_demo/widgets/calculator_widget.dart'; // ✅ Cambiado a package import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Testing Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const CalculatorWidget(),
    );
  }
}
