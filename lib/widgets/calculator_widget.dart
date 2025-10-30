import 'package:flutter/material.dart';
import '../models/calculator.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final Calculator _calculator = Calculator();
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();
  String _result = '';

  void _calculate(String operation) {
    final double a = double.tryParse(_controllerA.text) ?? 0;
    final double b = double.tryParse(_controllerB.text) ?? 0;
    
    try {
      setState(() {
        switch (operation) {
          case 'add':
            _result = _calculator.add(a, b).toString();
            break;
          case 'subtract':
            _result = _calculator.subtract(a, b).toString();
            break;
          case 'multiply':
            _result = _calculator.multiply(a, b).toString();
            break;
          case 'divide':
            _result = _calculator.divide(a, b).toString();
            break;
        }
      });
    } on ArgumentError catch (e) {
      setState(() {
        _result = 'Error: ${e.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            key: const Key('numberA_field'),
            controller: _controllerA,
            decoration: const InputDecoration(
              labelText: 'Number A',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextField(
            key: const Key('numberB_field'),
            controller: _controllerB,
            decoration: const InputDecoration(
              labelText: 'Number B',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => _calculate('add'),
                child: const Text('+'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('subtract'),
                child: const Text('-'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('multiply'),
                child: const Text('×'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('divide'),
                child: const Text('÷'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Result: $_result',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
    super.dispose();
  }
}