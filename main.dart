import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Calculator',
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});
  @override
  State<CalculatorApp> createState() => _Calculator();
}

class _Calculator extends State<CalculatorApp> {
  String input = '';
  String result = '';

  void onButtonTap(String value) {
    setState(() {
      if (value == 'AC') {
        input = '';
        result = '';
      } else if (value == '=') {
        try {
          String expression = input.replaceAll('×', '*').replaceAll('÷', '/');
          result = doCalculation(expression);
        } catch (e) {
          result = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  String doCalculation(String expression) {
  try {
    List<String> operators = ['+', '-', '*', '/', '%'];
    String operator = '';
    for (String op in operators) {
      if (expression.contains(op)) {
        operator = op;
        break;
      }
    }

    if (operator.isEmpty) {
      return expression;
    }

    List<String> parts = expression.split(operator);
    double a = double.parse(parts[0]);

    if (operator == '%' && (parts.length == 1 || parts[1].isEmpty)) {
      return "${a / 100}";
    }

    double b = double.parse(parts[1]);
    switch (operator) {
      case '+':
        return "${a + b}";
      case '-':
        return "${a - b}";
      case '*':
        return "${a * b}";
      case '/':
        return "${a / b}";
      case '%':
        return "${a % b}";
      default:
        return expression;
    }
  } catch (e) {
    return 'Error';
  }
} 
  Widget createButton(String text, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(3),
        child: ElevatedButton(
          onPressed: () => onButtonTap(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(22),
            textStyle: const TextStyle(fontSize: 22),
          ),
          child: Text(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M.Adeel (FA22-BSE-130)')
        ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            input,
            textAlign: TextAlign.right,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          Text(
            result,
            textAlign: TextAlign.right,
            style: const TextStyle(color: Colors.white, fontSize: 40),
          ),
          Row(
            children: [
              createButton('AC', Colors.grey),
              createButton('+/-', Colors.grey),
              createButton('%', Colors.grey),
              createButton('÷', Colors.orange),
            ],
          ),
          Row(
            children: [
              createButton('7', Colors.grey.shade800),
              createButton('8', Colors.grey.shade800),
              createButton('9', Colors.grey.shade800),
              createButton('×', Colors.orange),
            ],
          ),
          Row(
            children: [
              createButton('4', Colors.grey.shade800),
              createButton('5', Colors.grey.shade800),
              createButton('6', Colors.grey.shade800),
              createButton('-', Colors.orange),
            ],
          ),
          Row(
            children: [
              createButton('1', Colors.grey.shade800),
              createButton('2', Colors.grey.shade800),
              createButton('3', Colors.grey.shade800),
              createButton('+', Colors.orange),
            ],
          ),
          Row(
            children: [
              createButton('calc', Colors.grey.shade800),
              createButton('0', Colors.grey.shade800),
              createButton('.', Colors.grey.shade800),
              createButton('=', Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}
