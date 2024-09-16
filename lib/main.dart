import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matthew Barbrack Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _display = '';
  String _operation = '';
  double _firstOperand = 0;
  double _secondOperand = 0;

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '';
        _operation = '';
        _firstOperand = 0;
        _secondOperand = 0;
      } else if (value == '=') {
        _secondOperand = double.tryParse(_display) ?? 0;
        _display = _performOperation();
        _operation = '';
      } else if (['+', '-', '*', '/', '%'].contains(value)) {
        _firstOperand = double.tryParse(_display) ?? 0;
        _operation = value;
        _display = '';
      } else if (value == '^2') {
        _firstOperand = double.tryParse(_display) ?? 0;
        _operation = value;
        _display = _performOperation();
        _operation = '';
      } else {
        _display += value;
      }
    });
  }

  String _performOperation() {
    double result = 0;
    switch (_operation) {
      case '+':
        result = _firstOperand + _secondOperand;
        break;
      case '-':
        result = _firstOperand - _secondOperand;
        break;
      case '*':
        result = _firstOperand * _secondOperand;
        break;
      case '/':
        result = _firstOperand / _secondOperand;
        break;
      case '%':
        result = _firstOperand % _secondOperand;
        break;
      case '^2':
        result = _firstOperand * _firstOperand;
        break;
    }
    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _display,
                style: const TextStyle(fontSize: 48),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 4,
              children: <String>[
                '7', '8', '9', '/',
                '4', '5', '6', '*',
                '1', '2', '3', '-',
                'C', '0', '=', '+',
                '%', '^2', 
              ].map((value) {
                return GridTile(
                  child: ElevatedButton(
                    onPressed: () => _onPressed(value),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}