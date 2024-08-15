import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Vector Options Dropdown with Math'),
      ),
      body: Center(
        child: MultipleMathDropdowns(),
      ),
    ),
  ));
}

class MathDropdown extends StatefulWidget {
  final String initialValue;
  final List<String> options;
  final Function(String) onChanged;

  const MathDropdown({
    required this.initialValue,
    required this.options,
    required this.onChanged,
  });

  @override
  _MathDropdownState createState() => _MathDropdownState();
}

class _MathDropdownState extends State<MathDropdown> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedOption,
        decoration: const InputDecoration(
          border: InputBorder.none, // Remove default border
        ),
        onChanged: (String? newValue) {
          setState(() {
            selectedOption = newValue!;
          });
          widget.onChanged(newValue!);
        },
        items: widget.options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Math.tex(
              value,
              textStyle: TextStyle(fontSize: 20), // Customize as needed
            ),
          );
        }).toList(),
        selectedItemBuilder: (BuildContext context) {
          return widget.options.map<Widget>((String value) {
            return Math.tex(
              selectedOption,
              textStyle: TextStyle(fontSize: 20), // Customize as needed
            );
          }).toList();
        },
      ),
    );
  }
}

class MultipleMathDropdowns extends StatefulWidget {
  @override
  _MultipleMathDropdownsState createState() => _MultipleMathDropdownsState();
}

class _MultipleMathDropdownsState extends State<MultipleMathDropdowns> {
  String selectedOption1 = r'+\vec{a}_x';
  String selectedOption2 = r'-\vec{b}_y';

  final List<String> vect_a_E_Options = [
    r'+\vec{a}_x',
    r'-\vec{a}_x',
  ];

  final List<String> vect_b_E_Options = [
    r'+\vec{b}_y',
    r'-\vec{b}_y',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MathDropdown(
          initialValue: selectedOption1,
          options: vect_a_E_Options,
          onChanged: (newValue) {
            setState(() {
              selectedOption1 = newValue;
            });
          },
        ),
        const SizedBox(height: 20),
        MathDropdown(
          initialValue: selectedOption2,
          options: vect_b_E_Options,
          onChanged: (newValue) {
            setState(() {
              selectedOption2 = newValue;
            });
          },
        ),
      ],
    );
  }
}
