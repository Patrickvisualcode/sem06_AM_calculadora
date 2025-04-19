import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[300],
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          labelLarge: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(22.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurpleAccent,
          titleTextStyle: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          centerTitle: true,
        ),
      ),
      home: const CalculadoraPantalla(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculadoraPantalla extends StatefulWidget {
  const CalculadoraPantalla({super.key});

  @override
  State<CalculadoraPantalla> createState() => _CalculadoraPantallaState();
}

class _CalculadoraPantallaState extends State<CalculadoraPantalla> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0;
  String _operator = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentInput = "";
        _num1 = 0;
        _operator = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        _num1 = double.parse(_output);
        _operator = buttonText;
        _currentInput = "";
      } else if (buttonText == ".") {
        if (_currentInput.contains(".")) {
          return;
        }
        _currentInput += buttonText;
        _output = _currentInput;
      } else if (buttonText == "=") {
        double _num2 = double.parse(_output);
        if (_operator == "+") {
          _output = (_num1 + _num2).toString();
        }
        if (_operator == "-") {
          _output = (_num1 - _num2).toString();
        }
        if (_operator == "*") {
          _output = (_num1 * _num2).toString();
        }
        if (_operator == "/") {
          if (_num2 != 0) {
            _output = (_num1 / _num2).toString();
          } else {
            _output = "Error";
          }
        }
        _currentInput = _output;
        _num1 = 0;
        _operator = "";
      } else {
        _currentInput += buttonText;
        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(String buttonText, {int flex = 1, Color? color}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(
              color ?? Colors.blueGrey[400]!,
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).textTheme.labelLarge?.color ?? Colors.white,
            ),
          ),
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CALCULADORA')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const Divider(height: 1.0, color: Colors.black12),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("C", flex: 2, color: Colors.orangeAccent[400]),
                  _buildButton("+/-", color: Colors.grey[600]),
                  _buildButton("/", color: Colors.deepPurpleAccent),
                ],
              ),
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("*", color: Colors.deepPurpleAccent),
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("-", color: Colors.deepPurpleAccent),
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("+", color: Colors.deepPurpleAccent),
                ],
              ),
              Row(
                children: [
                  _buildButton("0", flex: 2),
                  _buildButton("."),
                  _buildButton("=", color: Colors.greenAccent[700]),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
