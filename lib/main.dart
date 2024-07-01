import 'package:flutter/material.dart';
import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';
import 'package:emwavepro/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Equation Input Example'),
        ),
        body: const EquationInputWidget(),
      ),
      themeMode: ThemeMode.light, //or ThemeMode.dark
      theme: GlobalThemeData.lightThemeData,
      darkTheme: GlobalThemeData.darkThemeData,
    );
  }
}

class EquationInputWidget extends StatefulWidget {
  const EquationInputWidget({super.key});

  @override
  _EquationInputWidgetState createState() => _EquationInputWidgetState();
}

class _EquationInputWidgetState extends State<EquationInputWidget> {
  String equationText = ''; // State variable to store the equation text

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Enter Equation',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                equationText = value; // Update equation text as user types
              });
            },
          ),
          const SizedBox(height: 20),
          Math.tex(
            equationText,
            mathStyle: MathStyle.display, // Render the equation using LaTeX
          ),
        ],
      ),
    );
  }
}